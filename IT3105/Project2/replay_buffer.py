import numpy as np
from typing import Union, Tuple


class ReplayBuffer:
    def __init__(self, size_x, size_y=0, max_size=10000, default_batch_size=128):
        """
        Initialization of the replay buffer. In itself a wrapper on numpy storage mimic-ing a queue.
        :param size_x: number of _attributes_ in the x-vector.
        :param size_y: number of outputs
        :param max_size: max number of observations to keep in the replay buffer. When hitting cap, the first element
        in, will be first to be tossed(FIFO).
        :param default_batch_size: default number of samples to generate when using minibatch(). Should be << max_size
        """
        self.size_x = size_x
        self.size_y = size_y
        self.max_size = max_size
        self.default_batch_size = default_batch_size

        self.__data_x = np.empty(shape=(self.max_size, self.size_x))
        self.__data_y = np.empty(shape=(self.max_size, self.size_y))

        # Stored observations: The number of elements stored in the internal storage
        self.__stored_observations = 0

    def append(self, x: Union[list, np.ndarray], y: Union[list, np.ndarray]) -> None:
        """
        Add x to self.__data_x, and y to self.__data_y
        :param x: Data to store in  the "x-data".
        :param y: Data to store in  the "y-data".
        :return: None
        """

        # Start with type conversions and sanity checks
        if isinstance(x, list):
            x = np.array(x)
        x = np.atleast_2d(x)
        if x.shape[1] == 1:  # Check if we have the data the right way around.
            x = np.transpose(x)
        if not x.shape[1] == self.size_x:
            raise ValueError(f"Problem: Replay-buffer wants x-values with dim {self.size_x}.\n"
                             f"Input data {x} had size {x.shape[1]}")

        else:
            y = np.array(y) if isinstance(y, list) else y
            y = np.atleast_2d(y)
            if y.shape[1] == 1:
                y = np.transpose(y)
            if not y.shape[1] == self.size_y:
                raise ValueError(f"Problem: Replay-buffer wants y-values with dim {self.size_y}.\n"
                                 f"Output values {y} had size {y.shape[1]}")

        if self.__stored_observations < self.max_size:

            # Still space left. Put it in place
            self.__data_x[self.__stored_observations] = x
            self.__data_y[self.__stored_observations] = y

            # increase counter
            self.__stored_observations += 1

        else:
            # We have run out of space. Append at the end.
            self.__data_x = np.vstack((self.__data_x[1:], x))
            self.__data_y = np.vstack((self.__data_y[1:], y))

    def save(self, filename: str = "./replay_buffer") -> None:
        """
        Store the data in a single text-file. To get them together we stack.
        :param filename: the file-name
        :return: Nothing
        """
        save_data = self.__data_x
        save_data = np.hstack((save_data, self.__data_y))
        np.savetxt(filename, save_data[:self.__stored_observations])  # only want to store the actual observations, not the np.empty-generated.

    def load(self, filename: str = "./replay_buffer") -> bool:
        """
        Load replay buffer from file. If self.size_y == 0 it means we will not be able to load y-values,
        and then do not attempt to load
        :param filename: the file-name.
        :return: Bool: able to do what we should?
        """

        # Start by flushing whatever is there already
        self.__data_x = np.empty(shape=(self.max_size, self.size_x))
        self.__data_y = np.empty(shape=(self.max_size, self.size_y))

        # attempt to load data
        try:
            load_data = np.atleast_2d(np.loadtxt(filename))
            # Check how many cases to keep. If there are too many in the file, we only save the last ones
            # that fit in our buffer
            self.__stored_observations = np.min((load_data.shape[0], self.max_size))  # abide by cap on the max amount we can load.
            if not load_data.shape[1] == self.size_x + self.size_y:  # Check whether the shape fits.
                raise ValueError(f"Shape of loaded data does not compute. Got {load_data.shape[1]} columns, when "
                                 f"expecting {self.size_x} + {self.size_y} = {self.size_x + self.size_y}.")

            self.__data_x[:self.__stored_observations] = \
                load_data[-self.__stored_observations:, :self.size_x]

            self.__data_y[:self.__stored_observations] = \
                load_data[-self.__stored_observations:, -self.size_y:]
            return True

        except (FileNotFoundError, ValueError, OSError) as e:
            print(f"Unable to load {filename}: {e}")  # Whatever error, we catch and print, but do not allow to interrupt.
            return False

    def minibatch(self, batch_size: np.int = None) -> Union[np.ndarray, Tuple[np.ndarray, np.ndarray]]:
        """
        Generate a random minibatch from the replay-buffer. The indexes are chosen with replacement
        from the values available. "with replacement" should not make much of a difference,
        because self.max_size >> batch_size making the probability of many multiple occurances low.
        :param batch_size:
        :return: We return a tuple (x_sub, y_sub) where x_sub and y_sub are random subsets from the buffer. Indexes
        match, so that x_sub[i] and y_sub[i] relate for all i.
        """
        if self.__stored_observations == 0:
            raise ValueError("Asking for minibatch when we dont have any data stored yet.")
        batch_size = self.default_batch_size if batch_size is None else batch_size
        chosen_index_values = np.random.randint(low=0, high=self.__stored_observations, size=batch_size)  # pick random indexes of data within our limits.
        return_value = self.__data_x[chosen_index_values], self.__data_y[chosen_index_values]

        return return_value