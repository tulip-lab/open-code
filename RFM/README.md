# RFM
---

| Field | Value |
| --- | --- |
| Title | RFM |
| Type | Source Code |
| Language | R and C/C++ |
| License |   |
| Status | Research Code |
| Update Frequency | NO |
| Date Published | 2013-01-31  |
| Date Updated |  2019-01-31 |
| Portal | https://github.com/tulip-lab/open-code |
| URL | https://github.com/tulip-lab/open-code/tree/master/RFM|
| Publisher |[TULIP Lab](http://www.tulip.org.au/) |
| Point of Contact |[A/Prof. Gang Li](https://github.com/tuliplab) |

This package (RFM) Programming library of fuzzy measure which provides various tools for handling fuzzy measures, calculating Shapley value and Interaction index,  Choquet Integrals, as well as fitting fuzzy measures to empirical data. 

It is distributed as a standard R package containing source code files, data sample, and examples. The routine code for fuzzy measure operation is mainly written in C/C++. We supply a `wrapper` function, which allows the operations and data input/output to be performed in the R environment.

There are two distribution files for this package:

* [`Rfmtool.zip`](Rfmtool.zip) is for Window users.
* [`Rfmtool.tar.gz`](Rfmtool.tar.gz) is for Linux users.


---
## Citations
---

If you use it for a scientific publication, please include a reference to this paper. 

* Huy Quan Vu, Gleb Beliakov and Gang Li. [A Choquet Integral Toolbox and Its Application in Customer Preference Analysis](http://books.google.com.au/books?id=nYpqAAAAQBAJ&pg=PA247&lpg=PA247&dq=A+Choquet+Integral+Toolbox+and+Its+Application+in+Customer+Preference+Analysis&source=bl&ots=wK84Bsn2D9&sig=sr_xiaV1bdYkObsKy2EdrK9yH4M&hl=en&sa=X&ei=6obWUumMMsjdkgXN9IDYDA&ved=0CD4Q6AEwAg#v=onepage&q=A%20Choquet%20Integral%20Toolbox%20and%20Its%20Application%20in%20Customer%20Preference%20Analysis&f=false).  in **Data Mining Application With R**. Elsevier, 2013 

`BibTex` information:


  @InBook{VBL13B01,
    chapter   = {A Choquet Ingtegral Toolbox and its Application in Customer's Preference Analysis},
    title     = {Data Mining Applications with R},
    publisher = {Elsevier},
    year      = {2013},
    author    = {Vu, Huy Quan and Beliakov, Gleb and Li, Gang},
    editor    = {Zhao, Yanchang and Cen, Yonghua},
    owner     = {Quan},
    timestamp = {2014.01.06},
  }

---
##  Installation
---

### For Window Users

The `Rfmtool.zip` is a standard R package for installation and operation in the Windows environment.

Windows users can install this package by selecting the installation package from local zip files menu bar in the R graphic user interface. Then select the Rfmtool.zip for installation.

The current package should work with R 3.1.2. If you are using a newer version of R, you may need to recompile the Rfmtool package. The instruction is as follow

* Download and install Rtool http://cran.r-project.org/bin/windows/Rtools/
* Add Class Path
```
        C:\Rtools\gcc-4.6.3\bin;
        C:\Rtools\bin;
        C:\Program Files\R\R-3.1.2\bin\x64
```
* Download the [`Rfmtool.tar.gz`](Rfmtool.tar.gz) 
* Open Command Prompt (cmd). Navigate to the location where you store Rfmtool.tar.gz and type 
```  
        R CMD INSTALL --build Rfmtool.tar.gz  
```        
It will compile into window package `Rfmool.zip` for both 32 and 64 bit.

### For Linux Users

The [`Rfmtool.tar.gz`](Rfmtool.tar.gz) is a standard R package for installation and operation in the Linux environment. It contains source code, data and examples.

Linux users can install this package by using the command:

```    
    R CMD INSTALL Rfmtool.tar.gz
```

Note that it requires C/C++ compiler gcc version 4.6.0 or above to be available for installation in Linux.


---
##  References
---

This package is developed based on the source code of a `fmtools` package for fuzzy measure operation:

* Beliakov, G. (2007). [fmtools package](http://www.deakin.edu.au/~gleb/aotool.html), version 1.0. 

The computation of this package depends on  `lpSolve` library, for solving linear, integer and mixed integer programs:

* Berkelaar, M. and Buttrey, S. (2011). [Interface to lp_solve v.5.5 to solve linear/integer programs](http://cran.r-project.org/web/packages/lpSolve/index.html). Version: 5.6.6 

For more background knowledge about fuzzy measure and Choquet integral. User can refer to the following book:

* Beliakov, G., Pradera, A., and Calvo, T. (2007). Aggregation Functions: A Guide for Practitioners. Springer, Heidelberg, Berlin, New York
