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

* Yishuo Zhang, Gang Li, Birgit Muskat, and Rob Law (2020). [Group Pooling For Deep Tourism Demand Forecasting](URL withhold). **Annals of Tourism**.

`BibTex` information:

   @article{ZLML2020,
    title = {Group Pooling For Deep Tourism Demand Forecasting},
    volume = {xx},
    doi = {xxxx},
    journal = {Annals of Tourism},
    author = {Zhang, Yishuo and Li, Gang and Muskat, Birgit and Law, Rob},
    month = xxx,
    year = {2020},
    keywords = {tourism demand forecasting, AI-based methodology, group-pooling method, deep-learning model, tourism demand similarity, Asia Pacific travel patterns},
    pages = {xxx},
    }

The related dataset for above paper can be found at [TULIP Lab Open-Data](https://github.com/tulip-lab/open-data):

* [`Pooling2020`](https://github.com/tulip-lab/open-data/tree/master/Pooling2020)


---
##  Requirements
---

* Python 3.6
* Keras 2.2 (2.3 won't work for the weights saving)
* Tensorflow




