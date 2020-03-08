from sklearn.preprocessing import MinMaxScaler
import pandas as pd
import numpy as np
from pandas import Series
from pandas import DataFrame
import statsmodels.api as sm
from scipy.spatial.distance import euclidean
from fastdtw import fastdtw


#import HK and MO data 
data_hk = pd.read_csv("HK-2018.csv")
data_mo = pd.read_csv("MO-2018.csv")


series_hk = data_hk[['Date','Arrival']]
series_hk.Date = pd.to_datetime(series_hk.Date,errors='coerce')
series_hk = series_hk.set_index('Date')


series_mo = data_mo[['Date','Arrival']]
series_mo.Date = pd.to_datetime(series_mo.Date,errors='coerce')
series_mo = series_mo.set_index('Date')

#decompose the data into trend / seasonality / noise
res_hk = sm.tsa.seasonal_decompose(series_hk)
res_mo = sm.tsa.seasonal_decompose(series_mo)
#scaling the data
scaler = MinMaxScaler()
trend_hk  = res_hk.trend.dropna()
trend_mo  = res_mo.trend.dropna()

sea_hk  = res_hk.seasonal.dropna()
sea_mo  = res_mo.seasonal.dropna()

trend_hk  = np.array(trend_hk ).reshape(-1,1)
trend_hk _nor = scaler.fit_transform(trend_hk )
trend_mo  = np.array(trend_mo ).reshape(-1,1)
trend_mo _nor = scaler.fit_transform(trend_mo )

sea_hk  = np.array(sea_hk ).reshape(-1,1)
sea_hk _nor = scaler.fit_transform(sea_hk )

sea_mo  = np.array(sea_mo ).reshape(-1,1)
sea_mo_nor = scaler.fit_transform(sea_mo )

distance1, path1 = fastdtw(trend_mo_nor.reshape(80,), trend_hk_nor.reshape(80,), dist=euclidean)
print(distance1)
distance2, path2 = fastdtw(sea_mo_nor, sea_hk_nor, dist=euclidean)
print(distance1)



