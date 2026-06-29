<p align="center">
  <img src="../assets/tulip-wordmark.png" alt="TULIP Lab" width="900">
</p>

# GP-DLM

| Field | Value |
| --- | --- |
| Title | GP-DLM |
| Type | Source Code |
| Language | Python |
| License | MIT License unless otherwise stated |
| Status | Research Code |
| Update Frequency | NO |
| Date Published | 2020-02-26 |
| Date Updated | 2020-02-26 |
| Portal | https://github.com/tulip-lab/open-code |
| URL | https://github.com/tulip-lab/open-code/tree/main/GP-DLM |
| Publisher | [TULIP Lab](http://www.tulip.academy/) |
| Point of Contact | [Prof. Gang Li](https://github.com/tuliplab) |

## Overview

This package contains the GP-DLM group pooling deep learning algorithm for tourism demand forecasting. The pooling stage uses dynamic time warping clustering to generate pooling groups, and pooled data is generated separately. Direct running of the provided code does not always generate the reported performance without dataset-specific training work.

## Repository location

The project is maintained in `GP-DLM/` in the TULIP Lab Open Code Repository:
https://github.com/tulip-lab/open-code/tree/main/GP-DLM

## Installation or environment

- Python 3.6.
- Keras 2.2. The original note says Keras 2.3 will not work for weight saving.
- Tensorflow.

## Usage

- Set up pooled data using `Dynamic_time_warping_distance.py` and `pooling.py`.
- Feed pooled data into DLM using `DLM.py` and `configuration.py`.
- Run `forecasting.py`.

## Data

The related dataset for the paper is hosted in the TULIP Lab Open Data Repository:

* [`HK-MO2018`](https://github.com/tulip-lab/open-data/tree/main/HK-MO2018).

Datasets used with this code are governed by their own licence and provenance notes.

## Citation

If you use this project for a scientific publication, please include a reference to the following paper.

* Yishuo Zhang, Gang Li, Birgit Muskat, Rob Law and Yating Yang (2020). [Group Pooling For Deep Tourism Demand Forecasting](https://doi.org/10.1016/j.annals.2020.102899). **Annals of Tourism Research**, Vol 82, May 2020.

`BibTeX` information:

```bibtex
@article{ZLMLY2020,
  title = {Group Pooling For Deep Tourism Demand Forecasting},
  volume = {82},
  doi = {10.1016/j.annals.2020.102899},
  journal = {Annals of Tourism Research},
  author = {Zhang, Yishuo and Li, Gang and Muskat, Birgit and Law, Rob and Yang, Yating},
  month = may,
  year = {2020},
  keywords = {tourism demand forecasting, AI-based methodology, group-pooling method, deep-learning model, tourism demand similarity, Asia Pacific travel patterns}
}
```

## Licence

Source code is licensed under the MIT License unless otherwise stated. Documentation, README text, and citation metadata are licensed under CC BY 4.0 unless otherwise stated. Datasets used with the code are licensed separately.

## Notes

The code publisher does not provide support for dataset-specific model training.
