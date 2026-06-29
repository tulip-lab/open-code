import numpy as np
import scipy.sparse as sp
import networkx as nx
from networkx.linalg.laplacianmatrix import laplacian_matrix

from scipy.sparse import csr_matrix, lil_matrix
from numpy import linalg as LA



def affinity(x, y):
    dot_xy = (np.dot(x, y))**2
    norm_x = (LA.norm(x))**2
    norm_y = (LA.norm(y))**2
    return dot_xy/(norm_x*norm_y)


def smooth_filter(laplacian_matrix, lda):
    dim = laplacian_matrix.shape[0]
    adj_matrix = sp.diags(laplacian_matrix.diagonal(), 0) - \
        laplacian_matrix + lda * sp.identity(dim)
    degree_vec = adj_matrix.sum(axis=1)
    with np.errstate(divide='ignore'):
        d_inv_sqrt = np.squeeze(np.asarray(np.power(degree_vec, -0.5)))
    d_inv_sqrt[np.isinf(d_inv_sqrt) | np.isnan(d_inv_sqrt)] = 0
    degree_matrix = sp.diags(d_inv_sqrt, 0)
    norm_adj = degree_matrix @ (adj_matrix @ degree_matrix)
    return norm_adj

def spec_coarsen(filter_, laplacian, n_target):
    np.random.seed(seed=1)

    # power of low-pass filter
    power = 2
    # number of testing vectors
    t = 7
    # threshold for merging nodes
    thresh = 0.3

    adjacency = sp.diags(laplacian.diagonal(), 0) - laplacian
    G = nx.from_scipy_sparse_array(adjacency)
    tv_list = []
    num_nodes = len(G.nodes())
    N = len(G.nodes())

    # generate testing vectors in [-1,1],
    # and orthogonal to constant vector
    for _ in range(t):
        tv = -1 + 2 * np.random.rand(num_nodes)
        tv -= np.ones(num_nodes)*np.sum(tv)/num_nodes
        tv_list.append(tv)
    tv_feat = np.transpose(np.asarray(tv_list))

    # smooth the testing vectors
    filter_ = filter_.tocsr()
    for _ in range(power):
        tv_feat = filter_ @ tv_feat
    matched = [False] * num_nodes
    degree_map = [0] * num_nodes

    # hub nodes are more important than others,
    # treat hub nodes as seeds
    for (node, val) in G.degree():
        degree_map[node] = val
    sorted_idx = np.argsort(np.asarray(degree_map))

    row = []
    col = []
    data = []
    cnt = 0
    for idx in sorted_idx:
        if matched[idx]:
            continue
        matched[idx] = True
        cluster = [idx]
        for n in G.neighbors(idx):
            if N <= n_target:
                break
            if affinity(tv_feat[idx], tv_feat[n]) > thresh and not matched[n]:
                cluster.append(n)
                matched[n] = True
                N -= 1
        row += cluster
        col += [cnt] * len(cluster)
        data += [1] * len(cluster)
        cnt += 1
    mapping = csr_matrix((data, (row, col)), shape=(num_nodes, cnt))
    coarse_laplacian = mapping.transpose() @ laplacian @ mapping
    return coarse_laplacian, mapping


def sim_coarse(laplacian, n_target):
    projections = []
    laplacians = []
    num = laplacian.shape[0]
    while num > n_target:
        filter_ = smooth_filter(laplacian, 0.1)
        laplacians.append(laplacian)
        laplacian, mapping = spec_coarsen(filter_, laplacian, n_target)
        projections.append(mapping)

        if laplacian.shape[0] <= n_target:
            break

    adjacency = sp.diags(laplacian.diagonal(), 0) - laplacian
    G = nx.from_scipy_sparse_array(adjacency, edge_attribute='wgt')
    return G, projections, laplacians
