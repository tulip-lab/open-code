\name{fm.fitting}
\alias{fm.fitting}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Fuzzy Measure Fitting function 

}
\description{
Esimate values of the fuzzy measures from empirical data.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
fm.fitting(data, kadd)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{is the empirical data set in pairs (x_1,y_1),(x_2,y_2),...,(x_d,y_d)
where x_i in [0,1]^n is a vector contains utility values of n input criteria
{x_{i1},x_{i2},...,x_{in}},
y_i in [0,1] is a single aggregated value given by decision makers. 
The data is stored
as a matrix of M by n+1 elements, where M is the number of data instances, 
and n is the number of input criteria, 
the column n + 1 store the observed aggregating value y.
%%     ~~Describe \code{x} here~~
}
  \item{kadd}{is the value of k-additivity, which is used for 
reducing the complexity of fuzzy measures.  
kadd is defined as an optional argument, its default
value is kadd = n.
%%     ~~Describe \code{v} here~~
}
  \item{output}{ The output result of the fitting function is an array of size 2^n
containing estimated Mobius fuzzy measure in binary ordering.}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
## The function is currently defined as
function(data,kadd="NA",...)
{
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
# This is a wrapper function which calls the main computation procedure in C/C++ code.  
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
