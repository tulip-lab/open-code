import math
import numpy as np
import matplotlib.pyplot as plt
from sklearn.neighbors import KDTree
from sklearn.neighbors import NearestNeighbors



def DTM(X, k):
    """
    Compute DTM2 scores for each point in X using k nearest neighbors.

    Parameters
    ----------
    X : array-like of shape (n_samples, n_features)
        Input point cloud.
    k : int
        Number of neighbors to use.

    Returns
    -------
    dtm2 : np.ndarray of shape (n_samples,)
        DTM2 score for each point.
    """
    # Fit neighbors (include self)
    nbrs = NearestNeighbors(n_neighbors=k+1).fit(X)
    dists, _ = nbrs.kneighbors(X)
    # exclude self-distance at index 0
    neigh_d2 = dists[:, 1:]**2
    # RMS over k neighbors
    dtm = np.sqrt(np.mean(neigh_d2, axis=1))
    return dtm
