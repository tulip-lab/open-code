# Rfmtool Package v1.0

# To cite package ‘Rfmtool’ in publications use:
# 	"Huy Quan Vu, Gleb Beliakov and Gang Li (2012). Rfmtool. R package version 1.0. 
#       	http://www.tulip.org.au/resources/rfmtool"

# This package is submitted for publication with a book chapter.
# 	"Huy Quan Vu, Gleb Beliakov and Gang Li. Data Mining Application With R.
#	 Chapter A Choquet Integral Toolbox and Its Application in Customer Preference Analysis. Elsevier, 2013."

# For more background knowledge about fuzzy measure and Choquet integral. User can refer to the following book:
#       " Beliakov, G., Pradera, A., and Calvo, T. (2007). Aggregation Functions: A Guide for Practitioners. 
#		Springer, Heidelberg, Berlin, New York"
		
# This package is developed based on the source code of a "fmtools" package for fuzzy measure operation:
#       "Beliakov, G. (2007).fmtools package, version 1.0. http://www.deakin.edu.au/~gleb/aotool.html"

# The computation of this package depends on  "lpSolve" library, for solving linear, integer and mixed integer programs:
# 	"Berkelaar, M. and Buttrey, S. (2011).Interface to lp_solve v.5.5 to solve linear/integer programs.
#		Version: 5.6.6 http://cran.r-project.org/web/packages/lpSolve/index.html"
#-----------------------------------------------------------------------------------------


fm <-function()
{
        #This function outputs a list of all functions included in this toolbox.
    
	print("A list of functions in Rfmtool Tool Box:")
	
	print("fm.fitting(data,kadd)")
	print("fm.Choquet(x,v)")
	print("fm.ChoquetMob(x,Mob)")
	print("fm.Mobius(v)")
	print("fm.Zeta(Mob)")
	print("fm.Shapley(v)")
	print("fm.Interaction(Mob)")
	print("fm.test()")
	
}

fm.fitting<- function(data,kadd="NA",...)
{
	#this function estimates the values of a k-additive fuzzy measure based on empirical data. 
	#The result is an array containing the values of the fuzzy measure in Mobius, ordered according to set cardinalities.
	#kadd define the complexity of fuzzy measure. if kadd is not provided, its default value is equal to the number of inputs.
	size <- dim(as.matrix(data));
	n <- size[2] - 1;
	datanum <- size[1];
	m = 2^n;
	MobiusVal <- array(0,m);
	
	if (kadd == "NA") 
	{
		kadd = n;
    	}
  	
	MobiusValue <- .C("fittingCall", as.integer(n),
	  				 as.integer(datanum),
	  				 as.integer(kadd),
			           out = as.numeric(MobiusVal),
			                 as.numeric(t(data)));
					
	return (MobiusValue$out);
}

fm.Choquet <- function(x,v)
{
	#Calculates the value of a discrete Choquet integral of an input x, with provided fuzzy measure v (in general representation)
	
	ChoquetVal <- -1; #this is just a initial value.
	ChoquetValue <- .C("ChoquetCall", as.numeric(x),
					  as.numeric(v),
				 	  as.integer(length(x)),
			            out = as.numeric(ChoquetVal));
        return (ChoquetValue$out);
}

fm.ChoquetMob <- function(x,Mob)
{
	#This is an alternative calculation of the Choquet integral from the Mobius fuzzy measure.
	
    ChoquetVal <- -1; #this is just a initial value.
	ChoquetMobValue <- .C("ChoquetMobCall", as.numeric(x),
					        as.numeric(Mob),
				 	        as.integer(length(x)),
			                  out = as.numeric(ChoquetVal));
	return (ChoquetMobValue$out);

}

		 		      

fm.Mobius<- function(v)
{
	#Calculates Mobius representation of the general fuzzy measure v
	  MobiusVal <-  array(0,length(v));
	  MobiusValue <- .C("MobiusCall", as.numeric(v), 
			            out = as.numeric(MobiusVal),
					  as.integer(log2(length(v))));
					
	  return (MobiusValue$out);
}

fm.Zeta<- function(Mob)
{
	#calculates the general fuzzy measure from its Mobius representation.
	  ZetaVal <- array(0,length(Mob));
	  ZetaValue <- .C("ZetaCall", as.numeric(Mob), 
			        out = as.numeric(ZetaVal),
				      as.integer(log2(length(Mob))));
					
	  return (ZetaValue$out);

}

fm.Shapley<- function(v)
{
	#calculates an array of Shapley values
	  ShapleyVal <- array(0,log2(length(v)));
	  ShapleyValue <- .C("ShapleyCall", as.numeric(v), 
			              out = as.numeric(ShapleyVal),
					    as.integer(log2(length(v))));
					
	  return (round(ShapleyValue$out, digits=4));

}


fm.Interaction<- function(Mob)
{
	# calculates all interaction indices 
	# result is a matrix, whose first column is the interaction index
	# and second column is the index of coliation.
	 coliation <- array(0,length(Mob));
	 InteractionVal <- array(0,length(Mob));
	 InteractionValue <- .C("InteractionCall", as.numeric(Mob), 
			                   inter = as.numeric(InteractionVal),
						   as.integer(log2(length(Mob))),
					   colia = as.integer(coliation));
	inteIndex <- as.matrix(InteractionValue$inter);
	coliaIndex <- as.matrix(InteractionValue$colia);
	index <- cbind(coliaIndex,inteIndex); 				
	return (round(index, digits=4));

}


fm.test <- function ()
{
	#Just a function to show that the toolbox has been installed succeffully.
	
	print("Choquet Integral from general fuzzy measure")
	print(fm.Choquet(c(0.6, 0.3, 0.8), c(0, 0.3, 0.5, 0.6, 0.4, 0.8, 0.7, 1)))
	
     	print("Choquet Integral from Mobius fuzzy measure")
	print(fm.ChoquetMob(c(0.6, 0.3, 0.8), c(0.0, 0.3, 0.5, -0.2, 0.4, 0.1, -0.2, 0.1)))
	
	print("Mobius transform")
	print(fm.Mobius(c(0, 0.3, 0.5, 0.6, 0.4, 0.8, 0.7, 1)))
	
	print("Zeta transform")
	print(fm.Zeta(c(0, 0.18, 0.15, -0.05, 0.23, 0.07, 0.18, 0.24)))
	
	print("Shapley value")
	print(fm.Shapley(c(0, 0.3, 0.5, 0.6, 0.4, 0.8, 0.7, 1)))
	
	print("Interaction Index")
	print(fm.Zeta(c(0, 0.18, 0.15, -0.05, 0.23, 0.07, 0.18, 0.24)))
	
}


