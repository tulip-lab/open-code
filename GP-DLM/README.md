# `GP-DLM`
---

| Field | Value |
| --- | --- |
| Title | GP-DLM |
| Type | Source Code |
| Language | Python |
| License |   |
| Data Status | Research Code |
| Update Frequency | NO |
| Date Published | 2020-02-26  |
| Date Updated |  2020-02-26 |
| Portal | https://github.com/tulip-lab/open-code |
| URL | https://github.com/tulip-lab/open-code/tree/master/GP-DLM|
| Publisher |[TULIP Lab](http://www.tulip.org.au/) |
| Point of Contact |[A/Prof. Gang Li](https://github.com/tuliplab) |

This package (GP-DLM) is the group pooling deep learning algorithm for tourism demand forecasting. Please be aware that:

* The pooling stage will need run the extra dynamic time warping clustering for generating the pooling group. 
* Pooling data is generated separately.
* The training of DLM needs extra efforts based on specific data set, and direct running of the provided code *DOES NOT* always generate the promised performance.
* For the training of the model on the data set, please spend your own patient time and the code publisher will *NOT* provide assistance on this issue.

---
## Citations
---

If you use it for a scientific publication, please include a reference to this paper.

* Yishuo Zhang, Gang Li, Birgit Muskat, Rob Law and Yating Yang(2020). [Group Pooling For Deep Tourism Demand Forecasting](https://doi.org/10.1016/j.annals.2020.102899). **Annals of Tourism Research**, Vol 82, May 2020


`BibTex` information:

    @article{ZLMLY2020,
    title = {Group Pooling For Deep Tourism Demand Forecasting},
    volume = {82},
    doi = {https://doi.org/10.1016/j.annals.2020.102899},
    journal = {Annals of Tourism Research},
    author = {Zhang, Yishuo and Li, Gang and Muskat, Birgit and Law, Rob and Yang, Yating},
    month = May,
    year = {2020},
    keywords = {tourism demand forecasting, AI-based methodology, group-pooling method, deep-learning model, tourism demand similarity, Asia Pacific travel patterns}, 
    }

The related dataset `HK-MO2018` for above paper can be found at [TULIP Lab Open-Data](https://github.com/tulip-lab/open-data):

* [`HK-MO2018`](https://github.com/tulip-lab/open-data/tree/master/HK-MO2018)


---
##  Requirements
---

* Python 3.6
* Keras 2.2 (2.3 won't work for the weights saving)
* Tensorflow


---
##  Run the coder
---

* Setting up the pooling data by using Dynamic_time_warping.py and pooling.py
* Feeding the pooled data into DLM by using DLM.py and configuration.py
* Run the forecasting.py 



