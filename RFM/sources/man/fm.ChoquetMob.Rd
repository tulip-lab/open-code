\name{fm.ChoquetMob}
\alias{fm.ChoquetMob}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ChoquetMob function 

}
\description{
This is an alternative calculation of the Choquet integral from the fuzzy measure in Mobius representation.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
fm.ChoquetMob(x, Mob)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{input vector of size n, containing utility value of input criteria.
  x is in [0,1].
%%     ~~Describe \code{x} here~~
}
  \item{Mob}{the Mobius fuzzy measure of size m=2^n. Its values can be provided by users,
  or by estimating from emperical data.
%%     ~~Describe \code{Mob} here~~
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
fm.ChoquetMob(c(0.6, 0.3, 0.8), c(0.0, 0.3, 0.5, -0.2, 0.4, 0.1, -0.2, 0.1))
## The function is currently defined as
function(x,Mob)
{
        ChoquetVal <- -1; #this is just a initial value.
	ChoquetMobValue <- .C("ChoquetMobCall", as.numeric(x),
					        as.numeric(Mob),
				 	        as.integer(length(x)),
			                  out = as.numeric(ChoquetVal));
	return (ChoquetMobValue$out);

  }
# This is a wrapper function which calls the main computation procedure in C/C++ code.  
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
