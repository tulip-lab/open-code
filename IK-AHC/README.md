<p align="center">
  <img src="../assets/tulip-wordmark.png" alt="TULIP Lab" width="900">
</p>

# IK-AHC

| Field | Value |
| --- | --- |
| Title | IK-AHC |
| Type | Source Code |
| Language | Matlab |
| License | BSD 3-Clause License |
| Status | Research Code |
| Update Frequency | NO |
| Date Published | 2022-04-16 |
| Date Updated | 2022-04-16 |
| Portal | https://github.com/tulip-lab/open-code |
| URL | https://github.com/tulip-lab/open-code/tree/main/IK-AHC |
| Publisher | [TULIP Lab](http://www.tulip.academy/) |
| Point of Contact | [Prof. Gang Li](https://github.com/tuliplab) |

## Overview

IK-AHC is a hierarchical clustering algorithm. It uses a data-dependent kernel called Isolation Kernel to measure similarity between clusters.

## Repository location

The project is maintained in `IK-AHC/` in the TULIP Lab Open Code Repository:
https://github.com/tulip-lab/open-code/tree/main/IK-AHC

## Installation or environment

- Matlab R2021a.

Set up the Matlab path:

```matlab
run setup.m
```

## Usage

Run the evaluation script:

```matlab
run eva/eva_khc.m
```

## Data

No standalone dataset is documented in this subproject README. Datasets used with the code should be checked for their own licence and provenance terms.

## Citation

If you use this project for a scientific publication, please include a reference to the following paper.

* Xin Han, Ye Zhu, Kai Ming Ting, and Gang Li, [The Impact of Isolation Kernel on Agglomerative Hierarchical Clustering Algorithms](https://arxiv.org/pdf/2010.05473.pdf), <i>arXiv e-prints</i>, 2020.

`BibTeX` information:

```bibtex
@article{HZTLThe2020,
  author = {Han, Xin and Zhu, Ye and Ting, Kai Ming and Li, Gang},
  title = {The Impact of Isolation Kernel on Agglomerative Hierarchical Clustering Algorithms},
  publisher = {arXiv},
  year = {2020},
  url = {https://arxiv.org/abs/2010.05473},
  copyright = {arXiv.org perpetual, non-exclusive license}
}
```

## Licence

This subproject includes its own [BSD 3-Clause License](LICENSE), which takes precedence for the subproject source code. Documentation, README text, and citation metadata are licensed under CC BY 4.0 unless otherwise stated.

## Notes

- Most of the running time is used to calculate dendrogram purity.
- Run the setup script before running the evaluation script.
