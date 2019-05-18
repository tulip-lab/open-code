\name{fm.Shapley}
\alias{fm.Shapley}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Shapley value computation function 
}
\description{Calculates the Shapley values of input criteria from general fuzzy measure,
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
fm.Shapley(v)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{v}{is fuzzy measure in general representation.}
  \item{output}{The output is an array of size n, which contain Shapley values of input criteria.}
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
fm.Shapley(c(0, 0.3, 0.5, 0.6, 0.4, 0.8, 0.7, 1))
## The function is currently defined as
function(v)
{
	ShapleyVal <- 1:log2(length(v));
	ShapleyValue <- .C("ShapleyCall", as.numeric(v), 
            			    out = as.numeric(ShapleyVal),
	as.integer(log2(length(v))));

	return (ShapleyValue$out);

}
# This is a wrapper function which calls the main computation procedure in C/C++ code.
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
