<p align="center">
  <img src="assets/tulip-wordmark.png" alt="TULIP Lab" width="900">
</p>

# TULIP Lab Open Code

The TULIP Lab Open Code Repository collects lab-released research software, reusable scripts, notebooks, and examples. It is paired with the TULIP Lab Open Data Repository, which hosts public datasets and dataset documentation.

- Point of Contact: [Prof. Gang Li](https://github.com/tuliplab)

Prepared by [TULIP Lab](http://www.tulip.academy), Australia

- 2026 maintainers: [Zonghao Chen](https://github.com/xhan97)
- 2022 maintainers: [Xin Han](https://github.com/xhan97)
- 2021 maintainers: [Chris Zhang](https://github.com/chriszhangpodo)
- 2020 maintainers: [Chris Zhang](https://github.com/chriszhangpodo)
- 2019 maintainers: [Xin Han](https://github.com/xhan97)

## Repository scope

This repository is for research software, examples, notebooks, and code documentation released by TULIP Lab. It may reference datasets, model artifacts, papers, or third-party resources, but those materials are governed by their own licence and provenance notes.

## Included projects

| Project | Path | Description |
|---|---|---|
| Adam | [`Adam/`](Adam) | Adaptive-maximum imputation for neighbourhood-based collaborative filtering, proposed in [*Lazy Collaborative Filtering for Datasets with Missing Values*](http://dx.doi.org/10.1109/TSMCB.2012.2231411), *IEEE Transactions on Systems, Man, and Cybernetics, Part B: Cybernetics*, 2013, 43(6): 1822-1834. |
| CTR | [`CTR/`](CTR) | Contrast Targeted Positive and Negative Association Rule Mining algorithm, proposed in [*Identifying Changes And Trends In Hong Kong Outbound Tourism*](http://dx.doi.org/10.1016/j.tourman.2010.09.011), *Tourism Management*, 2011, 32(5): 1106-1114. |
| DLM | [`DLM/`](DLM) | Deep learning package for tourism demand forecasting, proposed in [*Tourism Demand Forecasting: A Deep Learning Approach*](https://doi.org/10.1016/j.annals.2019.01.014), *Annals of Tourism Research*, Vol 75, March 2019, Page 410-423. |
| GP-DLM | [`GP-DLM/`](GP-DLM) | Group pooling tourism demand forecasting package, proposed in [*Group Pooling For Deep Tourism Demand Forecasting*](https://doi.org/10.1016/j.annals.2020.102899), *Annals of Tourism Research*, Vol 82, May 2020. |
| PREDICTIVITY | [`PREDICTIVITY/`](PREDICTIVITY) | Univariate time series predictivity code, proposed in [*Predictivity of tourism demand data*](https://doi.org/10.1016/j.annals.2021.103234), *Annals of Tourism Research*, May 2021. |
| RFM | [`RFM/`](RFM) | Tools for fuzzy measures, Shapley value, interaction index, Choquet integrals, and fitting fuzzy measures to empirical data, introduced in [*A Choquet Integral Toolbox and Its Application in Customer Preference Analysis*](http://books.google.com.au/books?id=nYpqAAAAQBAJ&pg=PA247&lpg=PA247&dq=A+Choquet+Integral+Toolbox+and+Its+Application+in+Customer+Preference+Analysis&source=bl&ots=wK84Bsn2D9&sig=sr_xiaV1bdYkObsKy2EdrK9yH4M&hl=en&sa=X&ei=6obWUumMMsjdkgXN9IDYDA&ved=0CD4Q6AEwAg#v=onepage&q=A%20Choquet%20Integral%20Toolbox%20and%20Its%20Application%20in%20Customer%20Preference%20Analysis&f=false), *Data Mining Application with R*, Elsevier, 2013. |
| STL-DADLM | [`STL-DADLM/`](STL-DADLM) | STL decomposition tourism demand forecasting package, proposed in [*Tourism Demand Forecasting: A Decomposed Deep Learning Approach*](https://doi.org/10.1177/0047287520919522), *Journal of Travel Research*, 2020. |
| IK-AHC | [`IK-AHC/`](IK-AHC) | Isolation Kernel agglomerative hierarchical clustering code for [*The Impact of Isolation Kernel on Agglomerative Hierarchical Clustering Algorithms*](https://arxiv.org/pdf/2010.05473.pdf), *arXiv e-prints*, 2020. |
| GANBLR | [`GANBLR/`](GANBLR) | Tabular data generation code for [*GANBLR: A Tabular Data Generation Model*](https://ieeexplore.ieee.org/abstract/document/9679177), *IEEE ICDM*, 2021. |
| StreaKHC | [`StreaKHC/`](StreaKHC) | Streaming hierarchical clustering based on point-set kernel, published in *The 28th ACM SIGKDD Conference on Knowledge Discovery & Data Mining (KDD '22)*, 2022. |
| Topograph | [`topograph/`](Topograph) | TULIP Lab TOPOGRAPH project, imported from https://github.com/tulip-lab/topograph. |

## Related data

Datasets used by examples or experiments may be hosted in the TULIP Lab Open Data Repository:
https://github.com/tulip-lab/open-data

Datasets are licensed separately. Please check the dataset-level licence, attribution, and provenance notes in the open-data repository before use.

## Citation

If you use a specific project in this repository, please cite the associated paper listed above or in that project's README.

For repository-level citation:

> TULIP Lab. *TULIP Lab Open Code Repository*. https://github.com/tulip-lab/open-code.

A repository-level DOI, release version, complete author list, or `CITATION.cff` may be added later as an optional future enhancement.

## Licence

Source code is licensed under MIT unless otherwise stated. Project-level licence files or third-party notices take precedence where present.

Documentation, README text, tutorial notes, and citation metadata are released under Creative Commons Attribution 4.0 International (CC BY 4.0) unless otherwise stated.

Datasets, model weights, third-party resources, papers, binaries, and checkpoints are governed by their own licences and are not automatically covered by this repository licence.

## Human review / known documentation issues

Known follow-up items are tracked in [HUMAN_REVIEW.md](HUMAN_REVIEW.md). Documentation audit details are recorded in [DOCS_AUDIT.md](DOCS_AUDIT.md).
