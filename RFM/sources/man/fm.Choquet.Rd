\name{fm.Choquet}
\alias{fm.Choquet}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Choquet function 

}
\description{
Calculates the value of a descrete Choquet integral of input x, with fuzzy measure in general representation  
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
fm.Choquet(x, v)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{input vector of size n, containing utility value of input criteria.
  x is in [0,1].
%%     ~~Describe \code{x} here~~
}
  \item{v}{the genral fuzzy measure of size m=2^n. Its values can be provided by users,
  or by estimating from emperical data.
%%     ~~Describe \code{v} here~~
}
  \item{output}{the ouput is a single value of the computed Choquet integral.}
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
##---- Should be DIRECTLY executable !! ----
fm.Choquet(c(0.6, 0.3, 0.8), c(0, 0.3, 0.5, 0.6, 0.4, 0.8, 0.7, 1))
## The function is currently defined as
function(x,v)
{
    #Calculates the value of a discrete Choquet integral of an input x, with provided fuzzy measure v (in general representation)
	
	ChoquetVal <- -1; #this is a default initial value.
	ChoquetValue <- .C("ChoquetCall", as.numeric(x),
					  as.numeric(v),
				 	  as.integer(length(x)),
			            out = as.numeric(ChoquetVal));
        return (ChoquetValue$out);
}
# This is a wrapper function which calls the main computation procedure in C/C++ code.  
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
