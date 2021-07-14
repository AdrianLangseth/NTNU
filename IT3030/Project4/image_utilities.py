import matplotlib.pyplot as plt
import numpy as np


def format_imgs(images, vert=None, show: bool = False, file_name: str = None):
    """
    Creates a nice representation and secures that imgaes which are to be compared end up ontop of each other.
    """
    if vert is None:
        height = int(np.sqrt(images.shape[0]))
        width = height
    else:
        height = vert
        width = int(float(images.shape[0]) / height)

    x_size, y_size, color_amount = images.shape[1:]
    full_img = np.zeros((height * x_size, width * y_size, color_amount))
    for index, img in enumerate(images):
        curr_x = index // width
        curr_y = index % width
        full_img[curr_x * x_size:(curr_x + 1) * x_size, curr_y * y_size:(curr_y + 1) * y_size, :] = img

    plt.Figure()
    if color_amount == 1:
        plt.imshow(full_img[:, :, 0], cmap="binary")
    else:
        plt.imshow(full_img.astype(np.float32), )
    plt.tight_layout()

    if file_name is not None:
        plt.savefig(file_name)

    if show is True:
        plt.show()

    # pyplot bs
    plt.clf()
    plt.cla()
    return

