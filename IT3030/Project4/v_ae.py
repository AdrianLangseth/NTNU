from auto_encoder import Autoencoder
from stacked_mnist import StackedMNISTData, DataMode
from image_utilities import format_imgs
import numpy as np

from keras.models import Model
from keras.layers import Reshape, Dense, Conv2D, Conv2DTranspose, Flatten, Input, Lambda
from keras.losses import binary_crossentropy
import keras.backend as K

import warnings

warnings.filterwarnings("ignore")


class VariationalAutoEncoder(Autoencoder):

    def __init__(self,
                 encoder_dim: np.int,
                 channels: np.int = 3,
                 must_train: bool = False,
                 file_name: str = "./models/vae_model") -> None:
        super(VariationalAutoEncoder, self).__init__(encoder_dim=encoder_dim, channels=channels,
                                                     must_train=must_train, file_name=file_name)

    def _gen_model(self):
        """
        Gen the encoder
        - save image_shape before dense layers to avoid np.reshape screwing us over again.
        Gen the decoder
        - Do re parameterization thing first
        Combine to make VAE
        """

        def sampling(args):
            """Re-parameterization trick of sampling. This allows us to learn mean and variance in network.

            args is the previous tensor. So this will be [self.z_mean, self.z_log_var],
            where zmean and z-log-var are tensors.
            """
            z_mean, z_var = args
            epsilon = K.random_normal(shape=(K.shape(z_mean)[0], K.int_shape(z_mean)[1]))  # Shape is num_samples, dim
            return z_mean + K.exp(z_var / 2) * epsilon

        # #-------#  ENCODER  #-------#
        self.input_layer = Input(shape=(28, 28, self.channels), name='input')
        x = Conv2D(self.channels * 48, (3, 3), activation='relu', padding='same', strides=2)(self.input_layer)
        x = Conv2D(self.channels * 72, (3, 3), activation='relu', padding='same', strides=2)(x)
        intermediary_shape = K.int_shape(x)
        encoding = Flatten()(x)
        encoding = Dense(128, activation='relu')(encoding)
        encoding = Dense(128, activation='relu')(encoding)

        self.z_mean = Dense(self.encoding_dim)(encoding)  # No Activation
        self.z_log_var = Dense(self.encoding_dim)(encoding)  # No Activation

        # do re-parameterization to get our ltent vector
        sampled_encoding = Lambda(sampling)([self.z_mean, self.z_log_var])
        self.encoding_layer = sampled_encoding

        # Save the encoded signal
        self.encoder = Model(self.input_layer, [self.z_mean, self.z_log_var, self.encoding_layer])
        # self.encoder.summary()

        # #-------#  DECODER  #-------#
        decoder_input = Input(shape=(self.encoding_dim,))

        x = Dense(128, activation='relu')(decoder_input)
        x = Dense(128, activation='relu')(x)
        x = Dense(intermediary_shape[1] * intermediary_shape[2] * intermediary_shape[3], activation='relu')(x)
        x = Reshape(target_shape=(intermediary_shape[1], intermediary_shape[2], intermediary_shape[3]))(x)
        x = Conv2DTranspose(self.channels * 48, (3, 3), activation='relu', padding='same', strides=2)(x)
        decoder_output = Conv2DTranspose(self.channels, (3, 3), activation='sigmoid', strides=2, padding='same')(x)

        self.decoder = Model(decoder_input, decoder_output)
        self.decoder.summary()

        self.output_layer = self.decoder(self.encoder(self.input_layer)[-1])

        self.auto_encoder = Model(self.input_layer, self.output_layer)
        self.auto_encoder.summary()

        def kl_reconstruction_loss(y, predicted):  # VAE ELBO from lecture
            reconstruction_loss = 28 * 28 * self.channels * binary_crossentropy(K.flatten(y), K.flatten(predicted))

            kl_loss = - 0.5 * K.sum(1 + self.z_log_var - K.square(self.z_mean) - K.exp(self.z_log_var), axis=-1)
            vae_loss = K.mean(reconstruction_loss + kl_loss)
            return vae_loss

        self.auto_encoder.compile(optimizer='rmsprop', loss=kl_reconstruction_loss)

    def anom_det(self, data, k):
        data_amount = data.shape[0]
        anomality = np.zeros((data_amount,))

        samples = self.decoder.predict(np.random.randn(1000, self.encoding_dim))
        # quick safeguard against logarithm bs
        e = 1e-8
        samples[samples < e] = e
        samples[samples > 1. - e] = 1. - e

        flata = np.reshape(data, (data_amount, -1))
        samples = np.reshape(samples, (samples.shape[0], -1))

        for idx in range(data_amount):  # Reconstruction probability and reconstruction error
            anomality[idx] = np.sum(np.mean(np.log(samples), axis=0) * flata[idx, :]) + np.sum(np.mean(np.log(1 - samples), axis=0) * 1 - flata[idx, :])

        data = data[np.argsort(anomality)[:k]]

        format_imgs(images=data, show=True, file_name='vae-anomalies.png')

        return


if __name__ == "__main__":
    mode = DataMode.MONO_BINARY_MISSING

    if mode is DataMode.COLOR_BINARY_MISSING:
        fp = './models/vae_color_20'
    elif mode is DataMode.MONO_BINARY_MISSING:
        fp = './models/vae_mono_20'
    else:
        raise NotImplementedError("Have not trained models on other modes than necessary.")

    gen = StackedMNISTData(mode=mode, default_batch_size=2048)
    vae = VariationalAutoEncoder(encoder_dim=20 * gen.channels * gen.channels,
                                 channels=gen.channels,
                                 must_train=False,
                                 file_name=fp)
    vae.demo(generator=gen, epochs=300)
