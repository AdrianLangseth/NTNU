from stacked_mnist import StackedMNISTData, DataMode
from verification_net import VerificationNet
from image_utilities import format_imgs

from keras import layers as KL
from keras import models as KM
from keras import backend as K
from keras import optimizers as KO
import numpy as np
from datetime import datetime
from matplotlib import pyplot as plt


class Autoencoder:

    def __init__(self, channels:int, encoder_dim, file_name: str = "./models/autoencoder_model", must_train=False):

        self.channels = channels
        self.encoding_dim = encoder_dim
        self.model_fp = file_name
        self.must_train = must_train
        self._gen_model()

    def _gen_model(self) -> None:
        """
        Build encoder, build decoder, build autoencoder from encoder and decoder
        :return:
        """
        # -- # ENCODER # -- #
        self.input_layer = KL.Input(shape=(28, 28, self.channels))
        x = KL.Conv2D(filters=32, kernel_size=(3, 3), activation='relu', padding='same', strides=2)(self.input_layer)
        x = KL.Conv2D(filters=64, kernel_size=(3, 3), activation='relu', padding='same', strides=2)(x)
        intermediary_shape = K.int_shape(x)
        encoding = KL.Flatten()(x)
        self.encoding_layer = KL.Dense(self.encoding_dim, activation='relu')(encoding)
        self.encoder = KM.Model(self.input_layer, self.encoding_layer)

        # -- # DECODER # -- #
        decoder_input = KL.Input(shape=(self.encoding_dim,))
        x = KL.Dense(intermediary_shape[1] * intermediary_shape[2] * intermediary_shape[3], activation='relu')(decoder_input)
        x = KL.Reshape(target_shape=(intermediary_shape[1],
                                     intermediary_shape[2],
                                     intermediary_shape[3]))(x)
        x = KL.Conv2DTranspose(32, (3, 3), activation='relu', padding='same', strides=2)(x)
        decoder_output = KL.Conv2DTranspose(self.channels, (3, 3), activation='sigmoid', strides=2, padding='same')(x)
        self.decoder = KM.Model(decoder_input, decoder_output)

        # -- # AUTOENCODER # -- #
        self.output_layer = self.decoder(self.encoder(self.input_layer))
        self.auto_encoder = KM.Model(self.input_layer, self.output_layer)
        self.auto_encoder.compile(optimizer=KO.Adam(.01), loss='binary_crossentropy')
        self.auto_encoder.summary()

    def train(self, generator, epochs, batch_size):
        try:
            self.auto_encoder.load_weights(filepath=self.model_fp + '.weights.h5')
            print(f"Loaded wights from file.")
            trained = True

        except:
            print(f"Failed to load {self.model_fp + '.weights.h5'}")
            trained = False

        if not trained or self.must_train:
            data, _ = generator.get_full_data_set(training=True)
            val_data, _ = generator.get_full_data_set(training=False)
            history = self.auto_encoder.fit(
                x=data,
                y=data,
                verbose=2,
                batch_size=batch_size,
                epochs=epochs,
                validation_data=(val_data, val_data)
            )
            self.auto_encoder.save_weights(filepath=self.model_fp + ".weights.h5")
            trained = True
            plt.plot(history.history["val_loss"])
            plt.show()
        return trained

    def reconstruct(self, data, plot=False, file_name: str = None):
        rec = self.auto_encoder.predict(data)
        if plot:
            format_imgs(np.concatenate([data, rec], axis=0), vert=2, show=True, file_name=file_name)

        return rec

    def generate_random_images(self, amount, plot:bool, file_name: str = None):
        data = self.decoder.predict(np.random.randn(amount, self.encoding_dim))

        if plot:
            format_imgs(images=data[:amount], show=True, file_name=file_name)

        return data

    def anom_det(self, data, k):
        """
        Calculate the reconstruction loss when evaluating test-data, and plot the most anomalous images.
        """

        data_amount = data.shape[0]
        flata = np.reshape(data, (data_amount, -1))
        recon = np.reshape(self.auto_encoder.predict(data), (data_amount, -1))

        anomality = np.zeros((data_amount,))

        # quick safeguard against logarithm bs
        e = 1E-8
        recon[recon < e] = e
        recon[recon > 1. - e] = 1. - e

        for data_idx in range(data_amount):  # Basically cross-entropy but the keras thing was buggy.
            anomality[data_idx] = np.sum(np.log(recon[data_idx, :]) * flata[data_idx, :]) + np.sum(np.log(1. - recon[data_idx, :]) * (1. - flata[data_idx, :]))

        # keep only most anomalous data
        data = data[np.argsort(anomality)[:k]]

        # show and push
        format_imgs(images=data, show=True)

    def demo(self, generator: StackedMNISTData, epochs):
        if self.channels == 3:
            tol = 0.5
            net = VerificationNet(force_learn=False, file_name="./models/verification_model_stacked")
            factor = 1/(1-0.111)
        elif self.channels == 1:
            tol = 0.8
            net = VerificationNet(force_learn=False)
            factor = 10/9
        else:
            raise ValueError(f"self.channels should be 1 or 3 but was {self.channels}")

        print(f"Tolerance set to {tol}, due to {self.channels} channels")
        self.train(generator=generator, epochs=epochs, batch_size=generator.default_batch_size)

        # AE-BASIC
        print('+' + '-' * 20 + 'Reconstruction' + '-' * 20 + '+')
        plot = True
        imgs, labels = generator.get_random_batch(training=True, batch_size=10 + (990*(1-plot)))
        data = self.reconstruct(data=imgs, plot=plot)
        cov = net.check_class_coverage(data=data, tolerance=tol)
        predictability, accuracy = net.check_predictability(data=data, correct_labels=labels, tolerance=tol)
        print(f"Coverage: {cov*factor:.2f} \nAccuracy: {accuracy:.2f}\nPredictability/Quality: {predictability:.2f}")

        # AE-GEN
        print('+' + '-' * 20 + 'Generative' + '-' * 20 + '+')
        gen_data = self.generate_random_images(amount=16, plot=True)

        gen_cov = net.check_class_coverage(gen_data, tolerance=tol)
        gen_pred, _ = net.check_predictability(gen_data, tolerance=tol)

        print(f"Coverage: {gen_cov*cov:.2f} \nPredictability/Quality: {gen_pred:.2f}")

        # AE-ANOM
        print('+' + '-' * 20 + 'Anomaly' + '-' * 20 + '+')
        imgs, _ = generator.get_random_batch(training=False, batch_size=160)
        self.anom_det(data=imgs, k=16)


if __name__ == '__main__':
    mode = DataMode.MONO_BINARY_MISSING

    if mode is DataMode.COLOR_BINARY_MISSING:
        fp = './models/10_color_autoencoder_model'
    elif mode is DataMode.MONO_BINARY_MISSING:
        fp = './models/10_mono_auto_encoder'
    else:
        raise NotImplementedError("Have not trained models on other modes than necessary.")

    gen = StackedMNISTData(mode=mode, default_batch_size=2048)
    ae = Autoencoder(encoder_dim=10 * gen.channels * gen.channels,
                     channels=gen.channels,
                     file_name=fp,
                     must_train=False)
    ae.demo(generator=gen, epochs=300)





