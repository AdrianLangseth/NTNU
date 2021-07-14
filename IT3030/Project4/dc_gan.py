from stacked_mnist import *
from verification_net import VerificationNet
from image_utilities import format_imgs

from keras import layers as KL
from keras import models as KM
from keras import optimizers as KO
import numpy as np
from tqdm.contrib.telegram import tqdm

class DCGAN:

    def __init__(self, channels, encoder_dim,
                 file_name: str = "./models/gan_model",
                 must_learn=False) -> None:
        self.channels = channels
        self.encoding_dim = encoder_dim
        self.model_fp = file_name
        self.must_learn = must_learn
        self._gen_model()

    def _gen_model(self):
        """
        Generates models. Uses binary crossentropy with LOW LR as described in the lectures.
        :return:
        """

        def gen_generator(input_shape):
            model = KM.Sequential()
            model.add(KL.Dense(1024, input_shape=input_shape, activation='tanh'))

            model.add(KL.Dense(128 * 7 * 7))
            model.add(KL.BatchNormalization())
            model.add(KL.Activation('tanh'))

            model.add(KL.Reshape((7, 7, 128)))
            model.add(KL.UpSampling2D(size=(2, 2)))

            model.add(KL.Conv2D(64, (5, 5), padding='same', activation='tanh'))
            model.add(KL.UpSampling2D(size=(2, 2)))

            model.add(KL.Conv2D(self.channels, (5, 5), padding='same', activation='tanh'))
            return model

        self.generator = gen_generator(input_shape=(self.encoding_dim,))

        def gen_discriminator(input_shape):
            model = KM.Sequential()
            model.add(
                KL.Conv2D(filters=64, kernel_size=(5, 5), padding='same', input_shape=input_shape, activation='tanh'))
            model.add(KL.MaxPooling2D(pool_size=(2, 2)))

            model.add(KL.Conv2D(128, (5, 5), activation='tanh'))
            model.add(KL.MaxPooling2D(pool_size=(2, 2)))

            model.add(KL.Flatten())
            model.add(KL.Dense(1024, activation='tanh'))
            model.add(KL.Dense(1, activation='sigmoid'))  # As suggested in the lectures.

            return model

        self.discriminator = gen_discriminator(input_shape=(28, 28, self.channels))

        def gen_GAN(generator: KM.Sequential, discriminator: KM.Sequential):
            model = KM.Sequential()
            model.add(generator)
            discriminator.trainable = False
            model.add(discriminator)
            return model

        self.gan = gen_GAN(self.generator, self.discriminator)

        self.generator.compile(loss='binary_crossentropy', optimizer=KO.SGD(lr=0.0004))
        self.gan.compile(loss='binary_crossentropy', optimizer=KO.SGD(lr=0.0005))
        self.discriminator.trainable = True
        self.discriminator.compile(loss='binary_crossentropy', optimizer=KO.SGD(lr=0.0008))

    def train(self, generator: StackedMNISTData, epochs: int = 10, batch_size: int = None):
        batch_size = generator.default_batch_size if batch_size is None else batch_size
        try:  # Try to load pretrained
            self.generator.load_weights(filepath=self.model_fp + ".generator.weights.h5")
            self.discriminator.load_weights(filepath=self.model_fp + ".discriminator.weights.h5")
            print(f"Loaded models successfully")
            trained = True
        except:  # Otherwise we need to train
            print(f"Failed loading {self.model_fp + '(generator/discriminator).weights.h5'}")
            trained = False

        if self.must_learn or trained is False:

            for _ in tqdm(range(epochs), token="",
                              chat_id=''):
                for index, (actual_images, _) in enumerate(generator.batch_generator(batch_size=batch_size)):
                    # gen fakes
                    generated_images = self.generator.predict(
                        np.random.uniform(-1, 1, size=(batch_size, self.encoding_dim)), verbose=0)
                    # get all images on same scale (-1,1)
                    all_images = np.concatenate((2. * actual_images - 1., generated_images))
                    y = np.asarray([1] * actual_images.shape[0] + [0] * batch_size)

                    # train
                    _ = self.discriminator.train_on_batch(all_images, y)
                    self.discriminator.trainable = False
                    _ = self.gan.train_on_batch(np.random.uniform(-1, 1, (batch_size, self.encoding_dim)), [1] * batch_size)
                    self.discriminator.trainable = True

                self.generator.save_weights(self.model_fp + ".generator.weights.h5", True)
                self.discriminator.save_weights(self.model_fp + ".discriminator.weights.h5", True)
        return

    def generate_random_images(self, batch_size: np.int = 144, show_images=False):
        """
        Throw random noise on the generator, show the images.
        """
        # throw random noise on the generator and get our generated images from the prediction.
        generated_images = self.generator.predict(np.random.uniform(-1, 1, (batch_size, self.encoding_dim)), verbose=0)

        # Show the images
        format_imgs(generated_images, show=show_images)
        return generated_images

    def gan_demo(self, generator: StackedMNISTData, training_epochs: np.int = 100) -> None:
        if self.channels == 3:
            tol = 0.5
            net = VerificationNet(force_learn=False, file_name="./models/verification_model_stacked")
        elif self.channels == 1:
            tol = 0.8
            net = VerificationNet(force_learn=False)
        else:
            raise ValueError(f"self.channels should be 1 or 3 but was {self.channels}")

        self.train(generator=generator, epochs=training_epochs)
        imgs = self.generate_random_images(show_images=True, batch_size=16)
        cov = net.check_class_coverage(imgs, tolerance=tol)
        pred, _ = net.check_predictability(imgs, tolerance=tol)
        print(f"Coverage: {cov:.2f} \nPredictability/Quality: {pred:.2f}")


if __name__ == "__main__":

    mode = DataMode.MONO_BINARY_COMPLETE

    if mode is DataMode.COLOR_BINARY_COMPLETE:
        fp = './models/color_gan_model'
    elif mode is DataMode.MONO_BINARY_COMPLETE:
        fp = './models/gan_model'
    else:
        raise NotImplementedError("Have not trained models on other modes than necessary.")

    gen = StackedMNISTData(mode=mode, default_batch_size=128)
    gan = DCGAN(encoder_dim=100 * gen.channels * gen.channels,
                channels=gen.channels,
                must_learn=False,
                file_name=fp)
    gan.gan_demo(gen, 10)

    # gan_model, color_gan_model
