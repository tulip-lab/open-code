!pip install pyts
#prepare to install the SSA library
from mySSA import mySSA
#https://github.com/aj-cloete/pssa
# load and read the HK data
series_sa = pd.read_csv('hongkong_new.csv', parse_dates=True, index_col='Date')
ssa = mySSA(series_sa['arrival'])
#setting SSA parameter
suspected_seasonality = 12
ssa.embed(embedding_dimension=30, suspected_frequency=suspected_seasonality, verbose=True
#plot the HK data
ssa.ts.plot(title='Original Time Series'); # This is the original series for comparison
streams5 = [i for i in range(5)]
#create the reconstruction 
reconstructed2 = ssa.view_reconstruction(*[ssa.Xs[i] for i in streams5], names=streams5, return_df=True)
# plot the reconstruction and calculate the entropy
X_sa =  reconstructed2.values.reshape(-1,)
msentropy_sa = ent.multiscale_entropy(X_sa,2,0.25*np.std(X_sa),30)
fig, ax1 = plt.subplots(figsize=(6, 4))
sns.lineplot(data=np.array(msentropy_or)[0:12], color="teal",label="Origin series entropy")
ax1.set_ylabel('Entropy')
ax1.set_xlabel('Scale level(months)')
sns.lineplot(data=np.array(msentropy_sa)[0:12], color="r",label="SSA series entropy")
plt.xticks([0,2,4,6,8,10],["1","3","5","7","9","11"]) 
plt.legend(loc='upper left')

# calculate the predictivity and plot 
phi_max_or=[]
phi_max_sa=[]
for i in range(len(msentropy_gt)):
  phi_max_or.append(phi_max(msentropy_or[i],280))
  phi_max_sa.append(phi_max(msentropy_sa[i],280))
  
fig, ax1 = plt.subplots(figsize=(6, 4))
sns.lineplot(data=np.array(phi_max_or)[0:12], color="teal",label="Origin series Phi_max")
ax1.set_ylabel('Phi_max')
ax1.set_xlabel('Scale level(months)')
sns.lineplot(data=np.array(phi_max_sa)[0:12], color="r",label="SSA series Phi_max")
plt.xticks([0,2,4,6,8,10],["1","3","5","7","9","11"]) 
plt.legend(loc='upper right')

