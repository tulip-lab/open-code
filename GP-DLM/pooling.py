from datetime import datetime
from numpy import nan
from numpy import isnan
import sklearn
import sklearn.preprocessing
import numpy as np
import configuration

dataset1 = read_csv('./data/hk2011-2018-stl.csv')
# manually specify column names
dataset1.index.name = 'date'
#dataset1 = dataset1[6:86]


df_finalfeature = dataset1.drop(['date','arrival','seasonality','trend'], axis=1)
df_finalfeature.replace(np.nan, 0, inplace=True)

np.where(np.isnan(df_finalfeature.values))

scaler = sklearn.preprocessing.MinMaxScaler()
df_finalfeature__nor = pd.DataFrame(scaler.fit_transform(df_finalfeature), columns=df_finalfeature.columns)
df_finalfeature__nor.describe()

df_df = pd.concat([df_finalfeature__nor,dataset1['arrival']/1000000],axis = 1)
df_df = df_df[6:86]
df_1 = df_df.as_matrix()  # convert to numpy array
data_1 = []

# create all possible sequences of length seq_len
for index in range(len(df_1) - 13):
    data_1.append(df_1[index: index + 13])




dataset2 = read_csv('./data/macau2011-2018-stl1.csv')
dataset2.index.name = 'date'
df_finalfeature1 = dataset2.drop(['date','arrival','seasonality','trend'], axis=1)
df_finalfeature1.replace(np.nan, 0, inplace=True)

np.where(np.isnan(df_finalfeature1.values))

scaler = sklearn.preprocessing.MinMaxScaler()
df_finalfeature__nor1 = pd.DataFrame(scaler.fit_transform(df_finalfeature1), columns=df_finalfeature1.columns)
df_finalfeature__nor1.describe()

df_df1 = pd.concat([df_finalfeature__nor1,dataset2['arrival']/1000000],axis = 1)
df_df1 = df_df1[6:86]
df_2 = df_df1.as_matrix()  # convert to numpy array
data_2 = []

# create all possible sequences of length seq_len
for index in range(len(df_2) - 13):
    data_2.append(df_2[index: index + 13])

data_1 = np.array(data_1)
y_1 = np.zeros((len(data_1), 1))
for i in range(0,len(y_1)):
    y_1[i]=data_1[i][12][256]


x_1 = np.zeros((len(data_1),12,257))
for i in range(0,len(x_1)):
    x_1[i]=data_1[i][0:12]

data_2 = np.array(data_2)
y_2 = np.zeros((len(data_2), 1))
for i in range(0,len(y_2)):
    y_2[i]=data_2[i][12][256]


x_2 = np.zeros((len(data_2),12,257))
for i in range(0,len(x_2)):
    x_2[i]=data_2[i][0:12]

train_x11215 = x_1[0:36]
train_y11215 = y_1[0:36]
train_x21215 = x_2[0:36]
train_y21215 = y_2[0:36]

test_x12016 = x_1[36:48]
test_y12016 = y_1[36:48]
test_x12017 = x_1[48:60]
test_y12017 = y_1[48:60]
test_x22016 = x_2[36:48]
test_y22016 = y_2[36:48]
test_x22017 = x_2[48:60]
test_y22017 = y_2[48:60]

train_x11217 = x_1[0:60]
train_y11217 = y_1[0:60]
train_x21217 = x_2[0:60]
train_y21217 = y_2[0:60]

train_1215 = np.concatenate((train_x11215, train_x21215), axis=0)
train_1215y = np.concatenate((train_y11215, train_y21215), axis=0)
shuffle = np.random.permutation(train_1215.shape[0])

train_1215_new=np.take(train_1215,shuffle,axis=0)
train_1215_newy=np.take(train_1215y,shuffle,axis=0)