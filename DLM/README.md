<p align="center">
  <img src="../assets/tulip-wordmark.png" alt="TULIP Lab" width="900">
</p>

# DLM

| Field | Value |
| --- | --- |
| Title | DLM |
| Type | Source Code |
| Language | Python |
| Licence | MIT License unless otherwise stated |
| Status | Research Code |
| Update Frequency | NO |
| Date Published | 2019-01-31 |
| Date Updated | 2019-01-31 |
| Portal | https://github.com/tulip-lab/open-code |
| URL | https://github.com/tulip-lab/open-code/tree/main/DLM |
| Publisher | [TULIP Lab](http://www.tulip.academy/) |
| Point of Contact | [Prof. Gang Li](https://github.com/tuliplab) |

## Overview

This package contains the DLM deep learning algorithm for tourism demand forecasting. The training of DLM needs extra effort for each specific dataset, and direct running of the provided code does not always generate the reported performance.

## Repository location

The project is maintained in `DLM/` in the TULIP Lab Open Code Repository:
https://github.com/tulip-lab/open-code/tree/main/DLM

## Installation or environment

- Python 3.6.
- Keras.
- Tensorflow.

## Usage

```bash
edit Setting.py
python Preprocess.py
python Eval.py
```

The preprocessing stage uses a window-based input with window size 12.

## Data

The related dataset for the paper is hosted in the TULIP Lab Open Data Repository:

* [`Macau2018`](https://github.com/tulip-lab/open-data/tree/main/Macau2018): Tourism Demand Forecasting Data for Macau from January 2011 to August 2018.

The project also includes local preprocessing artifacts under `preprocess/`. These artifacts are not automatically covered by the MIT code licence and require their own provenance review if reused outside this repository.

## Citation

If you use this project for a scientific publication, please include a reference to the following paper.

> Rob Law, Gang Li, Davis Fong, Xin Han (2019). [*Tourism Demand Forecasting: A Deep Learning Approach*](https://doi.org/10.1016/j.annals.2019.01.014). *Annals of Tourism Research*, Vol 75, March 2019, Page 410-423.

`BibTeX` information:

```bibtex
@article{LLFHDeep2019,
  title = {Tourism Demand Forecasting: A Deep Learning Approach},
  volume = {75},
  doi = {10.1016/j.annals.2019.01.014},
  journal = {Annals of Tourism Research},
  author = {Law, Rob and Li, Gang and Fong, Davis Ka Chio and Han, Xin},
  month = mar,
  year = {2019},
  keywords = {Big data analytics, Deep Learning, Search query data, Tourism Demand Forecast},
  pages = {410--423}
}
```

## Licence

Source code is licensed under the MIT License unless otherwise stated. Documentation, README text, and citation metadata are licensed under CC BY 4.0 unless otherwise stated. Datasets and preprocessing/model artifacts are governed by their own provenance and licence terms.

## Notes

The code publisher does not provide support for dataset-specific model training.
