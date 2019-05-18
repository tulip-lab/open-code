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

# This is an evaluation routine for Choquet Integral (CI)
# on the empirical Hotel data sets using 10-fold cross validation.

# Firstly, we define a function to compute Mean Absolute Error.
mae <- function(obs, pred) mean(abs(obs-pred))

# Then, we define a function containing the evaluation
# routine with $10$-fold cross validation.
evalfunc <- function(datafile,kadd)
{
    # datafile is the filename containing the empirical data set.
    # kadd is the value of k-additive.

    # Read the data set from file.
    data <- as.matrix(read.table(datafile));
    size <- dim(as.matrix(data));
    row <- size[1];
    col <- size[2];
    inputdim <- col - 1;

    # Evaluate the Choquet Integral using 10-fold cross validation.
    k <- 10;
    id <- sample(rep(seq_len(k), length.out=nrow(data)));

    maeVal <- array(0,c(1,k));	
    for (i in seq_len(k))
    {
        # Generate a training and a testing data set.
        test_matrix  <- data [id==i, ];
        train_matrix <- data [id!=i, ];
	
        # Estimate fuzzy measure from training data.
        estfuzzy <- fm.fitting(train_matrix,kadd);

        # Initialize arrays to save the output results.
        predicVal <- array(0,c(1,nrow(test_matrix)));
        originVal <- array(0,c(1,nrow(test_matrix)));

        count <- 1;
        for (f in seq_len(nrow(test_matrix)))
        {
            eachrec <- test_matrix[f,];
            # Compute Choquet Integral for each testing input.
            ChoVal <- fm.ChoquetMob(eachrec[1:col-1],estfuzzy);

            predicVal[count] <- ChoVal;
            originVal[count] <- eachrec[col];
            count <- count +1;
        }
        # Compute the Mean Absolute Error for each iteration.
        maeVal[i] <- mae(originVal,predicVal);
    }
    # Return the average of Mean Absolute Error.
    return(mean(maeVal));
}

# Below is the main evaluation routine which call function evalfunc 
# to evaluate each empirical data set.
# Specify the value for k-additive, which can be any value from 1 to 6.
kadd <- 6;

busierror <- array(0,c(1,10));
couperror <- array(0,c(1,10));
famierror <- array(0,c(1,10));


# We run the evaluation procedure 10 times and get the average error.
for (i in seq_len(10))
{
	busidata <- "../data/Preprocessed/Business.txt";
	busierror[i] <- evalfunc(busidata,kadd)

	coupdata <- "../data/Preprocessed/Couple.txt";
	couperror[i] <- evalfunc(coupdata,kadd)

	famidata <- "../data/Preprocessed/Family.txt";
	famierror[i] <- evalfunc(famidata,kadd)
}
mean(busierror)
mean(couperror)
mean(famierror)