<p align="center">
  <img src="../assets/tulip-wordmark.png" alt="TULIP Lab" width="900">
</p>

# GANBLR

| Field | Value |
| --- | --- |
| Title | GANBLR |
| Type | Source Code |
| Language | Python |
| Licence | MIT License unless otherwise stated |
| Status | Research Code |
| Update Frequency | NO |
| Date Published | 2022-04-30 |
| Date Updated | 2022-04-30 |
| Portal | https://github.com/tulip-lab/open-code |
| URL | https://github.com/tulip-lab/open-code/tree/main/GANBLR |
| Publisher | [TULIP Lab](http://www.tulip.academy/) |
| Point of Contact | [Prof. Gang Li](https://github.com/tuliplab) |

## Overview

GANBLR is a tabular data generation algorithm. It uses a higher-order discriminative Bayesian network and a neural network to generate synthetic tabular data.

## Repository location

The project is maintained in `GANBLR/` in the TULIP Lab Open Code Repository:
https://github.com/tulip-lab/open-code/tree/main/GANBLR

## Installation or environment

- Python 3.
- PGMPY.
- Pyitlib.
- Data must be discretized before being added as input.

## Usage

The project includes `GANBLR.ipynb` and `GANBLR_Extend.ipynb` notebooks. The README does not document a separate command-line workflow.

## Data

The project includes local Adult dataset files under `data/original/` and a discretized CSV under `data/discretized/`. Dataset files are governed by their own source and provenance terms and are not automatically covered by the MIT code licence.

## Citation

If you use this project for a scientific publication, please include a reference to the following paper.

> Yishuo Zhang, Nayyar Zaidi, Jiahui Zhou, and Gang Li, [*GANBLR: A Tabular Data Generation Model*](https://ieeexplore.ieee.org/abstract/document/9679177), *IEEE ICDM*, 2021.

`BibTeX` information:

```bibtex
@inproceedings{zhang2021ganblr,
  title = {GANBLR: A Tabular Data Generation Model},
  author = {Zhang, Yishuo and Zaidi, Nayyar A and Zhou, Jiahui and Li, Gang},
  booktitle = {2021 IEEE International Conference on Data Mining (ICDM)},
  pages = {181--190},
  year = {2021},
  organization = {IEEE}
}
```

## Licence

Source code is licensed under the MIT License unless otherwise stated. Documentation, README text, and citation metadata are licensed under CC BY 4.0 unless otherwise stated. Included datasets and third-party resources are governed by their own source terms.

## Notes

The previous README-level BSD wording has been replaced with the confirmed repository-default MIT wording for this subproject.
