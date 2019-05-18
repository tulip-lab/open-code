# To cite package ‘Rfmtool’ in publications use:
# 	"Huy Quan Vu, Gleb Beliakov and Gang Li (2012). Rfmtool. R package version 1.0. 
#       	http://www.tulip.org.au/resources/rfmtool"

# This package is submitted for publication with a book chapter.
# 	"Huy Quan Vu, Gleb Beliakov, Gang Li. A Choquet Ingtegral Toolbox and its Application 
#	 in Customer’s Preference Analysis. Book Chapter in Data Mining Applications with R. Elsevier, 2013."

# For more background knowledge about fuzzy measure and Choquet integral. User can refer to the following book:
#       " Beliakov, G., Pradera, A., and Calvo, T. (2007). Aggregation Functions: A Guide for Practitioners. 
#		Springer, Heidelberg, Berlin, New York"
		
# This package is developed based on the source code of a "fmtools" package for fuzzy measure operation:
#       "Beliakov, G. (2007).fmtools package, version 1.0. http://www.deakin.edu.au/~gleb/aotool.html"

# The computation of this package depends on  "lpSolve" library, for solving linear, integer and mixed integer programs:
# 	"Berkelaar, M. and Buttrey, S. (2011).Interface to lp_solve v.5.5 to solve linear/integer programs.
#		Version: 5.6.6 http://cran.r-project.org/web/packages/lpSolve/index.html"
#----------------------------------------------------------------------

# This example perform the estimation of fuzzy measure from data
# Compute Shapley value and Interaction Index.
# Here, we only demonstrate the computation of those values on a data set Business-Asia.txt.
# Other data set can be applied similarly.
library("Rfmtool")

# Load data from files.
busiasiadata <- as.matrix(read.table("../data/Preprocessed/Business-Asia.txt"))

# Estimate fuzzy measure from empirical data sets.
estimatedfuzzy <- fm.fitting(busiasiadata);

# The estimated fuzzy measures are in Mobius representation.
# Transform them to general representation here.
generalfuzzy  <- fm.Zeta(estimatedfuzzy);

# Compute Shapley value and Interaction Index
ShapleyVal <- fm.Shapley(generalfuzzy);
InteracVal <- fm.Interaction(estimatedfuzzy);

InterMatrix <- array(,c(6,6))
for (i in seq_len(nrow(InteracVal)))
{
       PairIndex <- InteracVal[i,1];
	 if(PairIndex > 10 && PairIndex <100)
	 {	
		ColInd <- PairIndex %% 10;
		RowInd <- (PairIndex  - ColInd)/10;
        	InterMatrix [RowInd,ColInd] = InteracVal[i,2]; 
	 }
}
	
ShapleyVal 
InterMatrix 
