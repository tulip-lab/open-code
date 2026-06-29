import math
import numpy as np
from scipy import sparse
from sklearn.neighbors import NearestNeighbors
from kneed import KneeLocator
from .aknn import AkNearestNeighbors
from .coarsening import *
from .DTM import *


class TOPOGRAPH:
    def __init__(self, dtm_k=30, k=30, n=1000):
        self.dtm_k = dtm_k
        self.k = k
        self.n = n

    def transform(self, X, dtm=True):
        if dtm:
            X_clean = self.get_clean_data(X)
        else:
            X_clean = X

        if not self.k:
            k_val = int(X_clean.shape[0] * 0.005)
        elif isinstance(self.k, int):
            k_val = self.k
        else:
            k_val = int(X_clean.shape[0] * self.k)

        S = self.get_aknng(X_clean, k_val)
        S.data = 1 - S.data / (np.max(S.data) + 1)

        d = S.sum(axis=1).A1
        D_sparse = sparse.diags(d, format='csr')
        L = D_sparse - S

        res = sim_coarse(L, self.n)
        proj = self.get_proj(res[1])
        try:
            coarse_laplacian = res[2][-1]
        except:
            coarse_laplacian = L

        return res[0], proj, L, coarse_laplacian, X_clean

    def get_aknng(self, X, n_neighbors, sigma=0, metric='euclidean',
                       include_self=False, is_sparse=True,):
        aknn = AkNearestNeighbors(n_neighbors=n_neighbors, sigma=sigma,
                              metric=metric, include_self=include_self,
                              is_sparse=is_sparse)

        aknn.aknneighbors_graph(X)
        return aknn.graph


    def get_clean_data(self, X):
        dtm = DTM(X, self.dtm_k)
        scores = np.sort(dtm)
        idx = np.arange(len(scores))
        knee = KneeLocator(idx, scores, curve="convex", direction="increasing", S=30)
        tau = scores[knee.knee]
        idx = np.where(dtm < tau)[0]
        result = X[idx, :]
        return result

    def get_proj(self, ps):
        try:
            rp = ps[0]
        except:
            return ps
        for p in ps[1:]:
            rp = rp @ p
        return rp

    def get_pos(self, src, proj):
        ncol = proj.shape[1]
        pos_set = []
        for i in range(ncol):
            row_indices = np.where(proj[:, i] == 1)
            pos = src[row_indices[0][0]]
            pos_set.append(pos)
        return np.array(pos_set)
