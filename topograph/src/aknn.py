import copy
import numpy as np
import networkx as nx
from networkx.linalg.laplacianmatrix import laplacian_matrix
from scipy.sparse import csr_matrix, lil_matrix
from sklearn.neighbors import kneighbors_graph
import networkx as nx
from scipy.sparse.linalg import eigs, eigsh
import scipy.sparse as sp


NEAR_ZERO_THRESHOLD = 1e-7


class AkNearestNeighbors(object):
    """

    Args:
        n_neighbors: int, optional, default=5
            Number of neighbors to estimate the density around the point.
            It appeared as a parameter `k` in the paper.

        delta: float, optional, default=1.0
            A parameter to decide the radius for each points. The combination
            radius increases in proportion to this parameter.

        metric: str, optional, default='euclidean'
            The metric of each points. This parameter depends on the parameter
            `metric` of scipy.spatial.distance.pdist.

        include_self: bool, optional, default=True
            All diagonal elements are 1.0 if this parameter is True.

        is_sparse: bool, optional, default=True
            The method `cknneighbors_graph` returns csr_matrix object if this
            parameter is True else returns ndarray object.
    """

    def __init__(self, n_neighbors=5, sigma=0, metric='euclidean',
                 include_self=False, is_sparse=True):
        self.n_neighbors = n_neighbors
        self.sigma = sigma
        self.metric = metric
        self.include_self = include_self
        self.is_sparse = is_sparse
        self.graph = None

    def aknneighbors_graph(self, X):
        """A method to calculate the AkNN graph

        Args:
            X: ndarray
                The data matrix.

        return: csr_matrix (if self.is_sparse is True)
                or ndarray(if self.is_sparse is False)
        """

        n_neighbors = self.n_neighbors
        sigma = self.sigma
        metric = self.metric
        include_self = self.include_self
        is_sparse = self.is_sparse

        n_samples = X.shape[0]

        if n_neighbors < 1 or n_neighbors > n_samples-1:
            raise ValueError("`n_neighbors` must be "
                             "in the range 1 to number of samples")
        if len(X.shape) != 2:
            raise ValueError("`X` must be 2D matrix")
        if n_samples < 2:
            raise ValueError("At least 2 data points are required")

        if metric == 'precomputed':
            if X.shape[0] != X.shape[1]:
                raise ValueError("`X` must be square matrix")
            dmatrix = X
        else:
            dmatrix = kneighbors_graph(X, n_neighbors, mode='distance', include_self=include_self, p=2)
        distX = copy.deepcopy(dmatrix)
        distX.data = distX.data ** (1/2)
        row_idx = []
        col_idx = []
        data = []
        sim = []

        for i in range(n_samples):
            neighbors_idx = distX[i].indices
            neighbors = distX[i].data
            similarities = 1 - ((n_neighbors-1 - sigma) * neighbors) / np.sum(neighbors)

            row_idx.extend([i] * n_neighbors)
            col_idx.extend(neighbors_idx)

            similarities[similarities < NEAR_ZERO_THRESHOLD] = 0
            similarities[similarities >= NEAR_ZERO_THRESHOLD] = 1

            data.extend(similarities)

        adjacency = sp.csr_matrix((data, (row_idx, col_idx)), shape=(n_samples, n_samples))
        diag_ptr = np.arange(n_samples)

        if include_self:
            adjacency[diag_ptr, diag_ptr] = 1
        else:
            adjacency[diag_ptr, diag_ptr] = 0
        rows, cols = adjacency.nonzero()
        adjacency[rows, cols] = np.multiply(np.array(adjacency[rows, cols])[0], np.array(adjacency[cols, rows][0]))
        #if t == 'np.inf':
        #dmatrix = adjacency
        #else:
        dmatrix = dmatrix.multiply(adjacency)
        if is_sparse:
            self.graph = dmatrix
        else:
            self.graph = dmatrix.toarray()

        return self.graph
