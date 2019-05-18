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
# This is an evaluation function for Arithmetic Mean (AM)
# on the imperical Hotel data sets using 10-fold cross validation.

library("Rfmtool")


# Function to compute Mean Absolute Error (MAE).
mae <- function(obs, pred) mean(abs(obs-pred))


# Function to evaluate a given data set using 10-fold cross validation
# Mean Absolute Error is used to measure the performance.

evalfunc <- function(datafile)
{
data <- as.matrix(read.table(datafile));
size <- dim(as.matrix(data));
row <- size[1];
col <- size[2];
inputdim <- col - 1;


# Evaluate the Arithmetic Mean using 10-fold cross validation,
k <- 10;
id <- sample(rep(seq_len(k), length.out=nrow(data)));

kadderror <- array(0,c(1,inputdim));

maeVal <- array(0,c(1,k));	
for (i in seq_len(k))
{
	test_matrix <- data [id==i, ];
      train_matrix <- data [id!=i, ];
	
	predicVal <- array(0,c(1,nrow(test_matrix)));
	originVal <- array(0,c(1,nrow(test_matrix)));

	count <- 1;
	for (f in seq_len(nrow(test_matrix)))
	{
		eachrec <- test_matrix[f,];
		#compute the Average value
		AMVal <-  mean(eachrec[1:col-1]) ;
		
		predicVal[count] <- AMVal;
		originVal[count] <- eachrec[col];
		count <- count +1;
	}
	maeVal[i] <- mae(originVal,predicVal);
}

return(mean(maeVal));
}


# The main evaluation routine is here.

# Load data from files.
# Perform 10-fold cross validation for different imperical data sets.

busierror <- array(0,c(1,10));
couperror <- array(0,c(1,10));
famierror <- array(0,c(1,10));

for (i in seq_len(10))
{
	busidata <- "../data/Preprocessed/Business.txt";
	busierror[i] <- evalfunc(busidata)

	coupdata <- "../data/Preprocessed/Couple.txt";
	couperror[i] <- evalfunc(coupdata)

	famidata <- "../data/Preprocessed/Family.txt";
	famierror[i] <- evalfunc(famidata)
}
mean(busierror)
mean(couperror)
mean(famierror)

# We run each experiment 10 times and get the average error.



