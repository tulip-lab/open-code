# DTM
---

| Field | Value |
| --- | --- |
| Title | DTM |
| Type | Source Code |
| Language | Python |
| License |   |
| Status | Research Code |
| Update Frequency | NO |
| Date Published | 2019-01-31  |
| Date Updated |  2019-01-31 |
| Portal | https://github.com/tulip-lab/open-code |
| URL | https://github.com/tulip-lab/open-code/tree/master/DTM|
| Publisher |[TULIP Lab](http://www.tulip.org.au/) |
| Point of Contact |[A/Prof. Gang Li](https://github.com/tuliplab) |

This package (DTM) is the deep learning algorithm for tourism demand forecasting.

---
## Citations
---

If you use it for a scientific publication, please include a reference to this paper. 

* Rob Law, Gang Li, Davis Fong, Xin Han (2019). Tourism Demand Forecasting: A Deep Learning Approach. Annals of Tourism Research

`BibTex` information:

    @article{LLFHDeep2019,
    title = {Tourism Demand Forecasting: A Deep Learning Approach},
    volume = {XX},
    issn = {XXX-XX},
    doi = {xxxxxx},
    journal = {Annals of Tourism Research},
    author = {Law, Rob and Li, Gang and Fong, Davis and Han, Xin},
    month = xxx,
    year = {2019},
    keywords = {Big data analytics, Deep Learning, Search query data,Tourism Demand Forecast},
    pages = {XX-XX},
    }

The related dataset for above paper can be found at [TULIP Lab Open-Data](https://github.com/tulip-lab/open-data):

* : [`Macau2018`](https://github.com/tulip-lab/open-data/tree/master/Macau2018) 


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


