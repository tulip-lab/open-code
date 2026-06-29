<p align="center">
  <img src="../assets/tulip-wordmark.png" alt="TULIP Lab" width="900">
</p>

# STL-DADLM

| Field | Value |
| --- | --- |
| Title | STL-DADLM |
| Type | Source Code |
| Language | Python |
| Licence | MIT License unless otherwise stated |
| Status | Research Code |
| Update Frequency | NO |
| Date Published | 2020-03-20 |
| Date Updated | 2020-03-20 |
| Portal | https://github.com/tulip-lab/open-code |
| URL | https://github.com/tulip-lab/open-code/tree/main/STL-DADLM |
| Publisher | [TULIP Lab](http://www.tulip.academy/) |
| Point of Contact | [Prof. Gang Li](https://github.com/tuliplab) |

## Overview

This package contains the STL-DADLM deep learning algorithm for tourism demand forecasting with STL decomposition. Direct running of the provided code does not always generate the reported performance without dataset-specific training work.

## Repository location

The project is maintained in `STL-DADLM/` in the TULIP Lab Open Code Repository:
https://github.com/tulip-lab/open-code/tree/main/STL-DADLM

## Installation or environment

- Python 3.6.
- Keras.
- Tensorflow.

## Usage

The README does not document a full command sequence. The included Python scripts are `Setting.py`, `STLPreprocess.py`, `DADLM.py`, and `Eval.py`.

## Data

The related dataset for the paper is hosted in the TULIP Lab Open Data Repository:

* [`HK2012-2018`](https://github.com/tulip-lab/open-data/tree/main/HK2012-2018): Tourism Demand Forecasting Data for Hong Kong on six visitor markets from January 2012 to December 2018.

Datasets used with this code are governed by their own licence and provenance notes.

## Citation

If you use this project for a scientific publication, please include a reference to the following paper.

> Yishuo Zhang, Gang Li, Birgit Muskat, Rob Law (2020). [*Tourism Demand Forecasting: A Decomposed Deep Learning Approach*](https://doi.org/10.1177/0047287520919522). *Journal of Travel Research*, June 2020.

`BibTeX` information:

```bibtex
@article{ZLML2020,
  title = {Tourism Demand Forecasting: A Decomposed Deep Learning Approach},
  volume = {0},
  doi = {10.1177/0047287520919522},
  journal = {Journal of Travel Research},
  author = {Zhang, Yishuo and Li, Gang and Muskat, Birgit and Law, Rob},
  month = jun,
  year = {2020},
  keywords = {Tourism demand forecasting, tourism planning, AI-based forecasting, deep learning, decomposing method, over-fitting}
}
```

## Licence

Source code is licensed under the MIT License unless otherwise stated. Documentation, README text, and citation metadata are licensed under CC BY 4.0 unless otherwise stated. Datasets used with the code are licensed separately.

## Notes

The code publisher does not provide support for dataset-specific model training.
