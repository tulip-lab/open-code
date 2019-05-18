\name{fm.test}
\alias{fm.test}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{A Test function
%%  ~~function to do ... ~~
}
\description{
This function provide some examples of how fuzzy measure operation functions in this toolbox are used.
It can be used to test if the toolbox has been installed successfully or not.
}
\usage{
fm.test()
}
%- maybe also 'usage' for other objects documented here.
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
function ()
{
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
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
