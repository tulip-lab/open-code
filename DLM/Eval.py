# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
from numpy import concatenate

import itertools

from sklearn.metrics import mean_squared_error 
from sklearn.metrics import mean_absolute_error
from math import sqrt

from DLM import build_model
from Setting import epochs,lstm_unit,drop_rate,dense_unit,batch_size_num
import pickle

def mean_absolute_percentage_error(y_true, y_pred): 
    y_true, y_pred = np.array(y_true), np.array(y_pred)
    return np.mean(np.abs((y_true - y_pred) / y_true))*100
  

def walk_forward(train_X,train_Y,test_X, test_Y,grid_search,scaler):
  r,f,c = test_X.shape
  for x in grid_search:
      history_x = np.array([x for x in train_X])
      history_y = np.array([y for y in train_Y])
      predictions = list()
      groundtrue = list()
      for i in range(len(test_X)):
        model = build_model(history_x,history_y,lstm_unit=x[0],drop_rate=x[1],dense_unit=x[2],batch_size=x[3],epochs=x[4])
      	# predict
        test = test_X[i].reshape(1,f,c)
        yhat = model.predict(test)
        inv_yhat,inv_y = inverscale(yhat,test_X[i],test_Y[i],scaler)
        predictions.append(inv_yhat)
        groundtrue.append(inv_y)
        
      	# observation
        obs_x = test_X[i]
        obs_y = test_Y[i]
        
        np.append(history_x,obs_x)
        np.append(history_y,obs_y)
              
      valuelist = evalue(predictions, groundtrue)
      valuelist['lstm_unit']=x[0]
      valuelist['drop_rate']=x[1]
      valuelist['dense_unit']=x[2]
      valuelist['batch_size']=x[3]
      valuelist['epochs']=x[4]
      saveresult(valuelist)
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
 
  
def inverscale(yhat,test_X,test_Y,scaler):
    
    feature = len(scaler.scale_)
    test_Y = np.array(test_Y)
    test_X = test_X[1,0:feature]  #40
    test_X = test_X.reshape(1,test_X.shape[0])
    
    if len(yhat.shape)==1:
        yhat = yhat.reshape(len(yhat),1)
        
    inv_yhat = concatenate((yhat,test_X[:,:-1]),axis=1)
    inv_yhat = scaler.inverse_transform(inv_yhat)
    inv_yhat = inv_yhat[:,0]
    
    test_Y = test_Y.reshape(1,1)
    inv_y = concatenate((test_Y,test_X[:,:-1]),axis=1)
    inv_y = scaler.inverse_transform(inv_y)
    inv_y = inv_y[:,0]
    return inv_yhat,inv_y
  
def saveresult(resultpd):
    import os
    csvFilePath = ".\\eval.csv"
    if not os.path.isfile(csvFilePath):
      resultpd.to_csv(csvFilePath, mode='a', index=False)
    else:
      resultpd.to_csv(csvFilePath, mode='a', index=False, header=False)
    
    return 0
    
  
if __name__ == '__main__':
  
    with open('.\\preprocess\\scaler.pk','rb') as f:
      scaler = pickle.load(f)
    with open('.\\preprocess\\reframed.pk','rb') as a:
      data = pickle.load(a)
    values = data.values
  
    n_train = 68
    train = values[:n_train,:]
    test = values[n_train:,:]
    test_X, test_Y = test[:,:-1],test[:,-1]
    train_X,train_Y = train[:,:-1],train[:,-1]
    
    train_X  = train_X.reshape(train_X.shape[0],12, int(train_X.shape[1]/12))
    test_X   = test_X.reshape(test_X.shape[0],12,int(test_X.shape[1]/12))
    
    grid_search = list(itertools.product(lstm_unit, drop_rate, 
                                dense_unit,batch_size_num,epochs))
    
    valuelist = walk_forward(train_X,train_Y,test_X, test_Y,grid_search,scaler)
    
    print(valuelist)
  