<p align="center">
  <img src="../assets/tulip-wordmark.png" alt="TULIP Lab" width="900">
</p>

# StreaKHC

| Field | Value |
| --- | --- |
| Title | StreaKHC |
| Type | Source Code |
| Language | Python, Shell |
| License | MIT License unless otherwise stated |
| Status | Research Code |
| Update Frequency | NO |
| Date Published | 2022-05-20 |
| Date Updated | 2022-05-20 |
| Portal | https://github.com/tulip-lab/open-code |
| URL | https://github.com/tulip-lab/open-code/tree/main/StreaKHC |
| Publisher | [TULIP Lab](http://www.tulip.academy/) |
| Point of Contact | [Prof. Gang Li](https://github.com/tuliplab) |

## Overview

StreaKHC is an incremental hierarchical clustering algorithm for efficiently mining massive streaming data. It uses a scalable point-set kernel to measure similarity between an existing cluster in the cluster tree and a new point in a stream, and it continuously maintains a cluster tree in real time.

## Repository location

The project is maintained in `StreaKHC/` in the TULIP Lab Open Code Repository:
https://github.com/tulip-lab/open-code/tree/main/StreaKHC

## Installation or environment

Download and install Anaconda Python 3:

```text
https://docs.continuum.io/anaconda/install
```

Install numba:

```bash
conda install numba
```

Set environment variables:

```bash
source bin/setup.sh
```

To visualize the built tree, install Graphviz:

```bash
sudo apt install graphviz
```

## Usage

Run the evaluation script:

```bash
./bin/run_grid_evaluation.sh
```

The evaluation result is shown in `/exp_out/` by default. For each randomly shuffled dataset, dendrogram purity and the generated tree figure are written to `score.tsv` and `tree.png`, respectively.

## Data

The project includes benchmark/sample datasets under `data/raw/` and `data/runned/`. These dataset files are governed by their own source and provenance terms and are not automatically covered by the MIT code licence.

## Citation

If you use this project for a scientific publication, please include a reference to the following paper.

* Xin Han, Ye Zhu, Kai Ming Ting, De-Chuan Zhan and Gang Li. *Streaming Hierarchical Clustering based on Point-Set Kernel.* In Proceedings of the 28th ACM SIGKDD Conference on Knowledge Discovery & Data Mining (KDD '22). 2022. https://doi.org/10.1145/3534678.3539323

`BibTeX` information:

```bibtex
@inproceedings{HZTZL22STREAMING,
  author = {Han, Xin and Zhu, Ye and Ting, Kai Ming and Zhan, De-Chuan and Li, Gang},
  title = {Streaming Hierarchical Clustering based on Point-Set Kernel},
  publisher = {Association for Computing Machinery},
  booktitle = {Proceedings of the 28th ACM SIGKDD Conference on Knowledge Discovery & Data Mining},
  series = {KDD '22},
  year = {2022},
  doi = {10.1145/3534678.3539323}
}
```

## Licence

Source code is licensed under the MIT License unless otherwise stated. Documentation, README text, and citation metadata are licensed under CC BY 4.0 unless otherwise stated. File-level third-party notices in source files take precedence where present. Included datasets and benchmark files are governed by their own source terms.

## Notes

- If tree visualization is not needed, the corresponding code in `/bin/run_evaluation.sh` can be commented out.
- Perl is used to shuffle the data. If Perl is unavailable, replace that step with another shuffling method.
- Source `bin/setup.sh` in each shell session used to run the project.
- Most of the running time is used to calculate dendrogram purity.
- The previous README-level BSD wording has been replaced with the confirmed repository-default MIT wording for this subproject.
