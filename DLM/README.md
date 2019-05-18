# DLM
---

| Field | Value |
| --- | --- |
| Title | DLM |
| Type | Source Code |
| Language | Python |
| License |   |
| Status | Research Code |
| Update Frequency | NO |
| Date Published | 2019-01-31  |
| Date Updated |  2019-01-31 |
| Portal | https://github.com/tulip-lab/open-code |
| URL | https://github.com/tulip-lab/open-code/tree/master/DLM|
| Publisher |[TULIP Lab](http://www.tulip.org.au/) |
| Point of Contact |[A/Prof. Gang Li](https://github.com/tuliplab) |

This package (DLM) is the deep learning algorithm for tourism demand forecasting.

---
## Citations
---

If you use it for a scientific publication, please include a reference to this paper. 

* Rob Law, Gang Li, Davis Fong, Xin Han (2019). [Tourism Demand Forecasting: A Deep Learning Approach](https://doi.org/10.1016/j.annals.2019.01.014). **Annals of Tourism Research**, Vol 75, March 2019, Page 410-423

`BibTex` information:

    @article{LLFHDeep2019,
    title = {Tourism Demand Forecasting: A Deep Learning Approach},
    volume = {75},
    doi = {10.1016/j.annals.2019.01.014},
    journal = {Annals of Tourism Research},
    author = {Law, Rob and Li, Gang and Fong, Davis Ka Chio and Han, Xin},
    month = March,
    year = {2019},
    keywords = {Big data analytics, Deep Learning, Search query data,Tourism Demand Forecast},
    pages = {410-423},
    }

The related dataset for above paper can be found at [TULIP Lab Open-Data](https://github.com/tulip-lab/open-data):

* [`Macau2018`](https://github.com/tulip-lab/open-data/tree/master/Macau2018): Tourism Demand Forcasting Data for Macau from January 2011 to August 2018


---
##  Requirements
---

* Python 3.6
* Keras
* Tensorflow


---
## Preprocessing
---

* Window-based input (window size is 12)


---
## Running
---

```
edit Setting.py         % set paramaters
python Preprocess.py    % data preprocess
python Eval.py          % model evaluation

```


