import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from pandas import datetime
import math, time
import itertools
from sklearn import preprocessing
import datetime
from operator import itemgetter
from sklearn.metrics import mean_squared_error
from math import sqrt
from keras.models import Sequential
from keras.layers.core import Dense, Dropout, Activation
from keras.layers.recurrent import LSTM
from keras.models import load_model
import keras
import h5py
import requests
import os
from keras.callbacks import LearningRateScheduler, TensorBoard , EarlyStopping, ModelCheckpoint, ReduceLROnPlateau

input_dim = 256
input_dim1 = 36
input_dim2 = 48
input_dim3 = 60
lstm_1 = 512
lstm_2 = 512
dense1 = 256
dense2 = 256