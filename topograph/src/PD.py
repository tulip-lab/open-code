import numpy as np
import gudhi as gd


def nor_mat(mat, max_val=None):

    mat_normalized = mat.copy().astype(float)

    if max_val is not None:
        mat_normalized[mat_normalized > max_val] = max_val

    not_inf_mask = mat_normalized != np.inf
    if np.any(not_inf_mask):
        max_num = np.max(mat_normalized[not_inf_mask])
    else:
        return np.ones_like(mat_normalized)

    inf_mask = mat_normalized == np.inf
    mat_normalized[inf_mask] = 1.0
    mat_normalized[~inf_mask] = mat_normalized[~inf_mask] / max_num

    return mat_normalized



def get_PD(points, max_edge_length, min_persistence, sparse=0.3, use_mat=True, dm=None):
    if use_mat:
        if dm is None:
            dm = distance.cdist(points, points)
            dm = nor_mat(dm)
        rips = gd.RipsComplex(distance_matrix=dm,\
                             max_edge_length=max_edge_length,\
                             sparse=sparse)
    else:
        rips = gd.RipsComplex(points=points,\
                             max_edge_length=max_edge_length,\
                             sparse=sparse)
    rips_st = rips.create_simplex_tree(max_dimension=2)
    print(rips_st)
    pers = rips_st.persistence(min_persistence=min_persistence)
    diag = rips_st.persistence_intervals_in_dimension(1)
    return diag
