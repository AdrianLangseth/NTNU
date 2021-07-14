import numpy as np
from collections import deque
import warnings
from PIL import Image
from tqdm import tqdm  # .contrib.telegram import tqdm


def check_modular_diff(patterns: tuple, modular: int):
    """
    Helper function to evaluate whether any patterns are congruent in respect to the size. If they are, their effects
    will be indistinguishable from each other.
    :param patterns: The data generation patterns as a tuple of integers.
    :param modular: The length of the data.
    :return: bool indicating whether the patterns are usable(not congruent in respect to data size)
    """

    mods = []
    for num in patterns:
        x = num % modular
        if x in mods:
            return False
        mods.append(x)
    return True


class DataGenerator:
    """
    each data sequence will look like this: list of lists of values
    [
    [1,0,0,0],
    [0,1,0,0],
    [0,0,1,0],
    [0,0,0,1]
    ]


    """
    def __init__(self, data_length=6, sequence_length=5):
        if not (data_length % 2 and data_length % 3 and data_length % 5 and data_length % 7):
            warnings.warn("Data length should be a prime to ensure no confusion or redundancy in relation to the "
                          "patterns.")

        self.data_length = data_length
        self.seq_length = sequence_length
        self.data = None

    def generate_data(self, sequence_amount_per_pattern:int = 20, patterns: tuple = (2, 1, -2, -3)):
        assert check_modular_diff(patterns, modular=self.data_length)

        # Need to wipe data if there is any there
        self.data = []  # ToDo: This should be a numpy array if not using minibatches but rather a single large batch
        print("Generating data, please stand by ...")
        for i in tqdm(range(sequence_amount_per_pattern)):
            initial = np.random.randint(2, size=self.data_length)

            # Check an recreate if all ones
            while (np.all(initial) or (not np.any(initial))):
                initial = np.random.randint(2, size=self.data_length)
            
            sequences = [[initial] for pattern in patterns]

            decks = [deque(initial) for pattern in patterns]

            for i in range(1, self.seq_length): # skip first as we already have initial.
                
                for idx, pattern in enumerate(patterns):
                    decks[idx].rotate(pattern)
                    sequences[idx].append(np.asarray(decks[idx]))
                    
            self.data.extend(sequences)

        return self.data

    def get_single_batch(self):  # This should not be used, should really use the genny.
        return np.asarray(self.data)

    def get_batches(self, batch_size: int):
        point = 0
        while True:
            batch = []
            if point + batch_size > len(self.data):
                of = point + batch_size - len(self.data)
                batch.append(np.concatenate((self.data[point:], self.data[:of])))
                point = of
            else:
                batch.append(self.data[point:point + batch_size])
                point += batch_size
            yield batch

    def visualize(self):
        img = Image.fromarray(np.asarray(self.data[0]).astype('uint8')*255.0)
        img.show()
        return True


if __name__ == '__main__':
    d = DataGenerator(data_length=20, sequence_length=20)
    print(d.generate_data(sequence_amount_per_pattern=2, patterns=(1, 2, 7)))
    d.visualize()
