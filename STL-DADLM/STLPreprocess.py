# -*- coding: utf-8 -*-

import pandas as pd
import numpy  as np
from numpy import concatenate
from math import sqrt
import pickle

from sklearn.preprocessing import MinMaxScaler

from minepy import MINE
import pandas as pd
from pandas import Series
from pandas import DataFrame

from matplotlib import pyplot
import statsmodels.api as sm


def stl(data):
  
   

	series = data[['date','arrival']]
	series.date = pd.to_datetime(series.date,errors='coerce')
	series = series.set_index('date')
    res = sm.tsa.seasonal_decompose(series)
	residual = res.resid.dropna()
	trend = res.trend.dropna()
	seaonality = res.seasonal.dropna()
	
    return to_drop


def Scaler(data):
  
    values = data.values
    values = values.astype('float32')
    scaler = MinMaxScaler(feature_range=(0,1))
    scaled = scaler.fit_transform(values)
    scaledDf = pd.DataFrame(scaled,columns=data.columns)
    return scaler,scaledDf


def series_to_supervised(data):
   
    
    dataset1 = data
	# manually specify column names
	dataset1.index.name = 'date'



	df_finalfeature = dataset1.iloc[:,4:]
	df_finalfeature.replace(np.nan, 0, inplace=True)

	np.where(np.isnan(df_finalfeature.values))

	scaler = sklearn.preprocessing.MinMaxScaler()
	df_finalfeature__nor = pd.DataFrame(scaler.fit_transform(df_finalfeature), columns=df_finalfeature.columns)
	#	x__nor = x
	df_finalfeature__nor.describe()

	df_df = pd.concat([df_finalfeature__nor,dataset1['arrival']/1000000,dataset1['seasonality']/1000000,dataset1['trend']/1000000],axis = 1)
	df_df = df_df[6:86]
	df_1 = df_df.as_matrix()  # convert to numpy array
	data_1 = []

	# create all possible sequences of length seq_len
	for index in range(len(df_1) - 13):
		data_1.append(df_1[index: index + 13])


	data_1 = np.array(data_1)
	y_1 = np.zeros((len(data_1), 1))
	for i in range(0,len(y_1)):
		y_1[i]=data_1[i][12][77]


	x_1 = np.zeros((len(data_1),12,78))
	for i in range(0,len(x_1)):
		x_1[i]=data_1[i][0:12]
    return x_1,y_1    
 
  
  
