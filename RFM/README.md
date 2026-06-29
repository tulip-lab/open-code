<p align="center">
  <img src="../assets/tulip-wordmark.png" alt="TULIP Lab" width="900">
</p>

# RFM

| Field | Value |
| --- | --- |
| Title | RFM |
| Type | Source Code |
| Language | R and C/C++ |
| License | MIT License unless otherwise stated |
| Status | Research Code |
| Update Frequency | NO |
| Date Published | 2013-01-31 |
| Date Updated | 2019-01-31 |
| Portal | https://github.com/tulip-lab/open-code |
| URL | https://github.com/tulip-lab/open-code/tree/main/RFM |
| Publisher | [TULIP Lab](http://www.tulip.academy/) |
| Point of Contact | [Prof. Gang Li](https://github.com/tuliplab) |

## Overview

RFM is a programming library for fuzzy measures. It provides tools for handling fuzzy measures, calculating Shapley values and interaction indexes, computing Choquet integrals, and fitting fuzzy measures to empirical data.

The library is distributed as a standard R package containing source code files, sample data, and examples. The fuzzy-measure routines are mainly written in C/C++, with wrapper functions for operation and data input/output in R.

## Repository location

The project is maintained in `RFM/` in the TULIP Lab Open Code Repository:
https://github.com/tulip-lab/open-code/tree/main/RFM

## Installation or environment

### Windows

`Rfmtool.zip` is a standard R package for installation and operation in the Windows environment. Windows users can install the package by selecting the installation package from local zip files menu in the R graphical user interface, then selecting `Rfmtool.zip`.

The current package should work with R 3.1.2. If using a newer version of R, recompilation may be required:

- Download and install Rtools: http://cran.r-project.org/bin/windows/Rtools/
- Add the relevant Rtools and R paths to the class path.
- Download [`Rfmtool.tar.gz`](Rfmtool.tar.gz).
- Open Command Prompt, navigate to the location where `Rfmtool.tar.gz` is stored, and run:

```bash
R CMD INSTALL --build Rfmtool.tar.gz
```

This compiles a Windows package for 32-bit and 64-bit R.

### Linux

[`Rfmtool.tar.gz`](Rfmtool.tar.gz) is a standard R package for installation and operation in the Linux environment. It contains source code, data, and examples.

Linux users can install this package with:

```bash
R CMD INSTALL Rfmtool.tar.gz
```

A C/C++ compiler such as gcc 4.6.0 or above is required for installation on Linux.

## Usage

Examples are included under `packages/example/` and `sources/inst/example/`.

## Data

RFM includes sample data and packaged binaries inside the distributed R package archives and extracted package folders. These sample data, binaries, and third-party-derived components are not automatically covered by the repository-level MIT code licence.

## Citation

If you use this project for a scientific publication, please include a reference to the following paper.

* Huy Quan Vu, Gleb Beliakov and Gang Li. [A Choquet Integral Toolbox and Its Application in Customer Preference Analysis](http://books.google.com.au/books?id=nYpqAAAAQBAJ&pg=PA247&lpg=PA247&dq=A+Choquet+Integral+Toolbox+and+Its+Application+in+Customer+Preference+Analysis&source=bl&ots=wK84Bsn2D9&sig=sr_xiaV1bdYkObsKy2EdrK9yH4M&hl=en&sa=X&ei=6obWUumMMsjdkgXN9IDYDA&ved=0CD4Q6AEwAg#v=onepage&q=A%20Choquet%20Integral%20Toolbox%20and%20Its%20Application%20in%20Customer%20Preference%20Analysis&f=false). In **Data Mining Application With R**. Elsevier, 2013.

`BibTeX` information:

```bibtex
@InBook{VBL13B01,
  chapter = {A Choquet Ingtegral Toolbox and its Application in Customer's Preference Analysis},
  title = {Data Mining Applications with R},
  publisher = {Elsevier},
  year = {2013},
  author = {Vu, Huy Quan and Beliakov, Gleb and Li, Gang},
  editor = {Zhao, Yanchang and Cen, Yonghua},
  owner = {Quan},
  timestamp = {2014.01.06}
}
```

## Licence

Source code is licensed under the MIT License unless otherwise stated. Documentation, README text, and citation metadata are licensed under CC BY 4.0 unless otherwise stated. Included sample data, package archives, compiled binaries, and third-party-derived components are governed by their own notices and source terms where present.

## Notes

This package is developed based on the source code of an `fmtools` package for fuzzy-measure operation:

* Beliakov, G. (2007). [fmtools package](http://www.deakin.edu.au/~gleb/aotool.html), version 1.0.

The computation of this package depends on the `lpSolve` library for solving linear, integer, and mixed integer programs:

* Berkelaar, M. and Buttrey, S. (2011). [Interface to lp_solve v.5.5 to solve linear/integer programs](http://cran.r-project.org/web/packages/lpSolve/index.html). Version: 5.6.6.

For more background on fuzzy measures and the Choquet integral, see:

* Beliakov, G., Pradera, A., and Calvo, T. (2007). Aggregation Functions: A Guide for Practitioners. Springer, Heidelberg, Berlin, New York.
