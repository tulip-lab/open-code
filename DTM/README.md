# DTM
---
- A Package for Tourism Demand Forecasting using Deep Learning Model
- You are free to use, change and distribute this package.

Prepared by [TULIP Lab](http://www.tulip.org.au), Australia

Maintainer: [Xin Han](https://github.com/xhan97)


---

---
###  Requirements
---
* Python 3.6
* Keras
* Tensorflow


---
### Preprocessing
---
* Window-based input (window size is 12)


---
### Running
---
```
edit Setting.py         % set paramaters
python Preprocess.py    % data preprocess
python Eval.py          % model evaluation

```
---
### Environment
---
* OS: Unbuntu 18.04
* CPU: Intel Xeon CPU E5-2620

### Citations
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
    keywords = {Big data analytics, Deep Learning, Search Query data, Tourism Demand Forecast},
    pages = {XX-XX},
    }

You can feel free to use the codes(for academic purpose only) at your own risk. For other purposes, please contact **A/Prof. Gang Li** (gangli AT tulip.org.au).
