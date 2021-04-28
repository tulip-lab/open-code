#!pip install pyentrp
# prepare the library on entropy calculation

import numpy as np
import pandas as pd
from pandas import read_csv
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter
from matplotlib.dates import YearLocator, DateFormatter
from pyentrp import entropy as ent
import seaborn as sns
from scipy.optimize import fsolve
from cmath import log 
from pylab import rcParams


# read data for plotting
df = read_csv('hongkong_new.csv')
def millions_formatter(x, pos):
    return int(x/1000000)

formatter = FuncFormatter(millions_formatter)

#ax1.yaxis.set_major_formatter(formatter)
fig, ax = plt.subplots(figsize=(12,6))
ax.plot(series_sa['arrival'],  linestyle='-')
ax.set_ylabel('Number of arrival (M)')
#ax.set_title('Jan-Feb 2017 Electricity Consumption')
# Set x-axis major ticks to weekly interval, on Mondays
ax.xaxis.set_major_locator(YearLocator(3))
#ax.xaxis.set_minor_locator(MonthLocator(bymonthday=15))
# Format x-tick labels as 3-letter month name and day number
ax.yaxis.set_major_formatter(formatter)


#calculate the entropy on different length
X=df.arrival.values.reshape(280,)

def entropy_cal(input, length, r=0.25):
	X_10=[]
	S10_s1=[]
	n=length
	for index in range(len(input) - n):
		X_10.append(input[index: index + n])
		
	for i in range(len(X_10)):
		msentropy = ent.multiscale_entropy(X_10[i],4,r*np.std(X_10[i]),20)
		S10_s1.append(msentropy[0])
	
	return X_10,S10_s1
	
list_10, S10_s1 = entropy_cal(X, 120)
list_5, S5_s1 = entropy_cal(X, 60)

# plot the length distribution
ax = sns.distplot(S10_s1,norm_hist=True,kde=True,color="teal",label="Entropy for 10-year data")
ax = sns.distplot( S5_s1 , color="red", label="Entropy for 5-year data",kde=True)
ax.set(xlabel='Entropy', ylabel='Probability Density')
#ns.distplot( S3_s1 , color="skyblue", label="Entropy for 3 years data")
plt.legend()


# calculate the predictivity by uing given entropy
def phi_max(s,length):
  func = lambda x: (-(x * log(x, 2).real + (1 - x) * log(1 - x, 2).real) + (1 - x) * log(length - 1, 2).real) - s
  ub = fsolve(func, 0.9)[0]
  return (ub)
  
 # calculate the predictivity on 10 years and 5 years
phi_max10=[]
for i in range(len(S10_s1)):
  phi_max10.append(phi_max(S10_s1[i],120))
  
  
phi_max5=[]
for i in range(len(S5_s1)):
  phi_max5.append(phi_max(S5_s1[i],60))
  
#plot the predictivity on  data length
p1=sns.kdeplot(np.array(phi_max10), shade=True, color="teal",label="Phi_max for 10-year data")
p1=sns.kdeplot(np.array(phi_max5), shade=True, color="r",label="Phi_max 5-year data")
p1.set(xlabel='Maximum predictability', ylabel='Probability Density')



# calculate the entropy on different scale
msentropy = ent.multiscale_entropy(X,2,0.25*np.std(X),30)
# calculate the predictivity on different scale
phi_max_all = []
for i in range(len(msentropy)):
  phi_max_all.append(phi_max(msentropy[i],280))

 # plot the predictivity on different scale
fig, ax1 = plt.subplots(figsize=(6,4))
sns.lineplot(data=np.array(phi_max_all), color="teal",label="Phi_max")
ax1.set_ylabel('Phi_max')

# plot the entropy on different scale
fig, ax1 = plt.subplots(figsize=(6,4))
ax1.set_ylabel('Entropy')
ax1.set_xlabel('Scale level(months)')
sns.lineplot(data=msentropy, color="r", ax=ax1,label="Entropy")
ax1.set_xlabel('Scale level(months)')

# define method to calculate entropy on different tolerance
def tolerance(X,level):
  msentropy = ent.multiscale_entropy(X,2,level*np.std(X),20)
  return msentropy

 # calculate the entropy on different tolerance
tolerance_level = np.array([0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7])
S_toler=[]
for i in range(len(tolerance_level)):
  S_toler.append(tolerance(X,tolerance_level[i]))
  
#plot the entropy on different tolerance   
palette = plt.get_cmap('Set1')
rcParams['figure.figsize'] = 6, 4
num=0
for i in [2,4,6,8,10,12]:
  num+=1
  sns.lineplot(data=S_toler[:,i], palette=palette,label="Scale level_"+str(i))
  #plt.title('Entropy', loc='left', fontsize=18, fontweight=2, color='k' )
  plt.xticks([0,2,4,6,8,10,12],["0.1","0.2","0.3","0.4","0.5","0.6","0.7",])
  plt.xlabel('Distance Parameter(r)')
  plt.ylabel('Entropy')
  
#plot the predictivity  on different tolerence
palette = plt.get_cmap('Set1')
rcParams['figure.figsize'] = 6, 4
num=0

for i in [2,4,6,8,10,12]:
  num+=1
  phi_max_t=[]
  for a in range(len(S_toler[:,i])):
    phi_max_t.append(phi_max(S_toler[:,i][a],280))
  phi_max_t=np.array(phi_max_t)
  sns.lineplot(data=phi_max_t, palette=palette,label="Scale level_"+str(i))
  #plt.title('Predictability', loc='left', fontsize=18, fontweight=2, color='k' )
  plt.xticks([0,2,4,6,8,10,12],["0.1","0.2","0.3","0.4","0.5","0.6","0.7",])
  plt.xlabel('Distance Parameter(r)')
  plt.ylabel('Phi_max')
  #plt.figure(figsize=(6,4))
plt.figure(figsize=(6,3))


#STL decomposition
from statsmodels.tsa.seasonal import seasonal_decompose
series = df.arrival
result = seasonal_decompose(series, model='addictive',freq=12)
trend = result.trend
season = result.seasonal
df_trend = trend[6:274]

X_gt=df_trend.values.reshape(268,)
msentropy_or = ent.multiscale_entropy(X,2,0.25*np.std(X),30)
msentropy_gt = ent.multiscale_entropy(X_gt,2,0.25*np.std(X_gt),30)

fig, ax1 = plt.subplots(figsize=(6, 4))
sns.lineplot(data=np.array(msentropy_or)[0:12], color="teal",label="Origin series entropy")
ax1.set_ylabel('Entropy')
ax1.set_xlabel('Scale level(months)')

# calculate the entropy on STL and Original
sns.lineplot(data=np.array(msentropy_gt)[0:12], color="r",label="Trend series entropy")
plt.xticks([0,2,4,6,8,10],["1","3","5","7","9","11"]) 
plt.legend(loc='upper left')

# calculate the predictivity on STL and Original
phi_max_or=[]
phi_max_tr=[]
for i in range(len(msentropy_gt)):
  phi_max_or.append(phi_max(msentropy_or[i],280))
  phi_max_tr.append(phi_max(msentropy_gt[i],268))

fig, ax1 = plt.subplots(figsize=(6, 4))
sns.lineplot(data=np.array(phi_max_or)[0:12], color="teal",label="Origin series Phi_max")
ax1.set_ylabel('Phi_max')
ax1.set_xlabel('Scale level(months)')
sns.lineplot(data=np.array(phi_max_tr)[0:12], color="r",label="Trend series Phi_max")
plt.xticks([0,2,4,6,8,10],["1","3","5","7","9","11"]) 
plt.legend(loc='upper right')

