# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
import itertools

from sklearn.metrics import mean_squared_error 
from sklearn.metrics import mean_absolute_error
from math import sqrt

import DTM
import Setting
import pickle

def mean_absolute_percentage_error(y_true, y_pred): 
    y_true, y_pred = np.array(y_true), np.array(y_pred)
    return np.mean(np.abs((y_true - y_pred) / y_true))*100
  

def walk_forward(train_X,train_Y,test_X, test_Y,grid_search):
  for x in grid_search:
      history = [x for x in train_X]
      predictions = list()
      for i in range(len(test_X)):
        model = build_model(tranin_X,train_Y,epochs,lstm_unit=x[0],drop_rate=x[1],dense_unit=x[2],batch_size=x[3])
      	# predict
        yhat = model.predict(test_X[i])
        yhat = inverscale(yhat)
        predictions.append(yhat)
      	# observation
        obs = test[i]
        history.append(obs)
      valuelist = evalue(predictions, test_Y)
  return valuelist

     
def evalue(yhat,inv_y):
    valuelist = {}
    DLM_rmse = sqrt(mean_squared_error(inv_y,yhat))
    valuelist.update({'RMSE':{'DLM':DLM_rmse}})
    DLM_mae = mean_absolute_error(inv_y,yhat)
    valuelist.update({'MAE':{'DLM':DLM_mae}})
    DLM_mape = mean_absolute_percentage_error(inv_y,yhat)
    valuelist.update({'MAPE':{'DLM':DLM_mape,}})
    return pd.DataFrame(valuelist)
 
  
def inverscale(yhat,test_Y,test_X,scaler):
    
    #if len(test_X.shape)>=3:
    test_X = test_X[:,1:2]  #40
    print(len(test_X))
    if len(yhat.shape)==1:
        yhat = yhat.reshape(len(yhat),1)
    print(yhat.shape)    
    inv_yhat = concatenate((yhat,test_X[:,:-1]),axis=1)
    inv_yhat = scaler.inverse_transform(inv_yhat)
    inv_yhat = inv_yhat[:,0]
    test_Y = test_Y.reshape(len(test_Y),1)
    inv_y = concatenate((test_Y,test_X[:,:-1]),axis=1)
    inv_y = scaler.inverse_transform(inv_y)
    inv_y = inv_y[:,0]
    return inv_yhat,inv_y
  
if __name__ == '__main__':
  
    with open('.\\preprocess\\scaler.pk','rb') as f:
      scaler = pickle.load(f)
    with open('.\\preprocess\\reframed.pk','wb') as a:
      data = pickle.load(a)
    values = data.values
  
    n_train = 68
    train = values[:n_train,:]
    test = values[n_train,:]
    test_X, test_Y = test[:,:-1],test[:,-1]
    train_X,train_Y = train[:,:-1],train[:,-1]
    
    train_X  = train_X.reshape(train_X.shape[0],12, int(train_X.shape[1]/12))
    test_X   = test_X.reshape(test_X.shape[0],12,int(test_X.shape[1]/12))
    
    grid_search = list(itertools.product(lstm_unit, drop_rate, 
                                dense_unit,batch_size_num))
    
    valuelist = walk_forward(train_X,train_Y,test_X, test_Y,grid_search)
  