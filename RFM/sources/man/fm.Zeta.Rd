\name{fm.Zeta}
\alias{fm.Zeta}
\title{Zeta transform function}  
%%  ~~function to do ... ~~
\description{Calculates the general fuzzy measure from Mobius representation. 
the input and output is an array of size 2^n=m in binary ordering.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{fm.Zeta(Mob)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Mob}{ fuzzy measure value in Mobius representation.
}
  \item{output}{the output is the fuzzy measure in general representation.}
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
fm.Zeta(c(0, 0.18, 0.15, -0.05, 0.23, 0.07, 0.18, 0.24))
## The function is currently defined as
function(Mob)
{
	  ZetaVal <- array(0,length(Mob));
	  ZetaValue <- .C("ZetaCall", as.numeric(Mob), 
			        out = as.numeric(ZetaVal),
				      as.integer(log2(length(Mob))));
					
	  return (ZetaValue$out);

}
# This is a wrapper function which calls the main computation procedure in C/C++ code.
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
