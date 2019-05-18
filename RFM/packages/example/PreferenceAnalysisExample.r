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

# Load the Rfmtool package
library("Rfmtool")

# Load data from files. Assume that the file data.txt is stored
# in the working directory.
data <- as.matrix(read.table("data.txt"))

# Estimate fuzzy measure (in Mobius representation) from empirical data sets.
# Here, the kadd value is not specified, thus kadd is assigned with
# the default value as kadd = n = 3.
Mobfuzzy <- fm.fitting(data)

# Transform the estimated Mobius fuzzy measure into general
# fuzzy measure by calling Zeta transform function.
Genfuzzy <- fm.Zeta(Mobfuzzy)

# User can try converting the general fuzzy measure back to
# Mobius fuzzy measure by calling Mobius transform function.
fm.Mobius(Genfuzzy)
# The result is expected to be exactly the same as in the Mobfuzzy array.

# User can try computing the Choquet Integral general fuzzy measure for a new input
# x with rating values as (0.8, 0.4, 0.6).
x <- c(0.8, 0.4, 0.6)
fm.Choquet(x,Genfuzzy)

# Compute the Choquet Integral from Mobius fuzzy measure for the same input x.
fm.ChoquetMob(x,Mobfuzzy)

# Compute Shapley values
ShapleyVal <- fm.Shapley(Genfuzzy)

# Compute Interaction Index values
InterVal <- fm.Interaction(Mobfuzzy)


