\name{fm.Mobius}
\alias{fm.Mobius}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Mobius transform function

}
\description{calculates Mobius representation of general fuzzy measure,
the input and output is an array of size 2^n=m in binary ordering.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
fm.Mobius(v)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{v}{fuzzy measure value in standard representation.}
  \item{output}{the output is the fuzzy measure in Mobius representation.}
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
fm.Mobius(c(0, 0.3, 0.5, 0.6, 0.4, 0.8, 0.7, 1))
## The function is currently defined as
function(v)
{
          MobiusVal <-  array(0,length(v));
	  MobiusValue <- .C("MobiusCall", as.numeric(v), 
	  			    out = as.numeric(MobiusVal),
	  		                  as.integer(log2(length(v))));
	  					
	  return (MobiusValue$out);
}
# This is a wrapper function which calls the main computation procedure in C/C++ code.
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
