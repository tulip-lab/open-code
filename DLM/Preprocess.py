# -*- coding: utf-8 -*-

import pandas as pd
import numpy  as np
from numpy import concatenate
from math import sqrt
import pickle

from sklearn.preprocessing import MinMaxScaler

from minepy import MINE


def micfliter(data,rate):
  
    """
        MIC feture selection function
        Arguments: 
          data:  Pandas DataFrame of 
          rate:  Float in range(0,1)
        Return: 
          List of to drop
    """

    m = MINE()  
    micmatrix = []
    for colx in data.columns:
        micResult = []
        for coly in data.columns:
            m.compute_score(np.array(data[coly]), np.array(data[colx])) 
            micResult.append(m.mic())
        micmatrix.append(micResult)
        
    micmatrix = pd.DataFrame(micmatrix,columns=data.columns)
    upper = micmatrix.where(np.triu(np.ones(micmatrix.shape), k=1).astype(np.bool))
    to_drop = [column for column in upper.columns if any(upper[column]>rate)]
    
    return to_drop


def Scaler(data):
  
    """
        Scaler all feature to range(0,1)
        Arguments: 
          data:  Pandas DataFrame of data
        Return:
          scaler: scaler
          scaledDf:Pandas DataFrame of scaled data
    """
    
    values = data.values
    values = values.astype('float32')
    scaler = MinMaxScaler(feature_range=(0,1))
    scaled = scaler.fit_transform(values)
    scaledDf = pd.DataFrame(scaled,columns=data.columns)
    return scaler,scaledDf


def series_to_supervised(data, n_in=1, n_out=1, dropnan=True):
    """
    Frame a time series as a supervised learning dataset.
    Arguments:
        data: Sequence of observations as a list or NumPy array.
        n_in: Number of lag observations as input (X).
        n_out: Number of observations as output (y).
        dropnan: Boolean whether or not to drop rows with NaN values.
    Returns:
        Pandas DataFrame of series framed for supervised learning.
    """
    
    n_vars = 1 if type(data) is list else data.shape[1]
    df = pd.DataFrame(data)
    cols, names = list(), list()
    # input sequence (t-n, ... t-1)
    for i in range(n_in, 0, -1):
        cols.append(df.shift(i))
        names += [('var%d(t-%d)' % (j+1, i)) for j in range(n_vars)]
    # forecast sequence (t, t+1, ... t+n)
    for i in range(0, n_out):
        cols.append(df.shift(-i))
        if i == 0:
            names += [('var%d(t)' % (j+1)) for j in range(n_vars)]
        else:
            names += [('var%d(t+%d)' % (j+1, i)) for j in range(n_vars)]
    # put it all together
    agg = pd.concat(cols, axis=1)
    agg.columns = names
    # drop rows with NaN values
    if dropnan:
        agg.dropna(inplace=True)
    
    agg.drop(agg.columns[-(df.shape[1]-1):],axis = 1,inplace=True)
    return agg    
 
  
  
if __name__ == '__main__':
    
    data = pd.read_csv(".\\dataset\\Macau2018.csv")
    data.drop(columns=["date","arrival mainland"],inplace=True)
    data.fillna(0,inplace=True)
    
    data_x = data[data.columns[1:]] 
    droplist = micfliter(data_x,rate=0.9)
    reducedData = data.drop(droplist, axis=1)
    
    scaler,scaledDf = Scaler(reducedData)
    reframed = series_to_supervised(scaledDf,n_in=12)
    
    with open('.\\preprocess\\scaler.pk','wb') as f:
      pickle.dump(scaler, f)
    with open('.\\preprocess\\reframed.pk','wb') as a:
      pickle.dump(reframed, a)
  