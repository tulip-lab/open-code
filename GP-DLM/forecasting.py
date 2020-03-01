import configuation
import DLM
import pooling
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


def mape_vectorized_v2(a, b):
    mask = a != 0
    return (np.fabs(a - b)/a)[mask].mean()


lstm_unit = [512,256,128,64,32]
drop_1 = [0.2,0.3,0.5,0.7]
dense_unit = [128,64,32]
drop_2 = [0.2,0.3,0.5]
batch_size_num = [7,12]

grid_search_ = list(itertools.product(lstm_unit, drop_1, dense_unit, drop_2, batch_size_num))

history_x = [x for x in train_x]
history_y = [y for y in train_y]
history_x_a = np.array(history_x)
history_y_a = np.array(history_y)
predictions = []
mape_error = []

for x in grid_search_[0:2]:
    history_x = [x for x in train_x]
    history_y = [y for y in train_y]
    history_x_a = np.array(history_x)
    history_y_a = np.array(history_y)
    mape_error1 = []
    predictions1 = []
    for i in range(len(test_x)):
            # 预测
        model= dlm(history_x_a,history_y_a,test_x[i], test_y[i],x[0],x[1],x[2],x[3],x[4])
        yhat = model.predict(test_x[i])
        error = mape_vectorized_v2(test_y[i],yhat)
        mape_error1.append(error)
        predictions1.append(yhat)
            # 观测+
        history_x_a = np.append(history_x_a,test_x[i],axis = 0)
        history_y_a = np.append(history_y_a,test_y[i],axis = 0)
    print(x,mape_error1)