\name{fm.Interaction}
\alias{fm.Interaction}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Interaction Index computation function 

}
\description{Calculates all the interaction indices of input criteria from Mobius fuzzy measure.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
fm.Interaction(Mob)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Mob}{fuzzy measure value in Mobius representation}
  \item{output}{the output is a matrix, whose first column stores the interaction
index values, and the second column stores the indices of criteria in coalitions.}
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
fm.Interaction(c( 0.0, 0.3, 0.5, -0.2, 0.4, 0.1, -0.2, 0.1))
## The function is currently defined as
function(Mob)
{
        coliation <- array(0,length(Mob));
	InteractionVal <- array(0,length(Mob));
        InteractionValue <- .C("InteractionCall",  as.numeric(Mob), 
			                   inter = as.numeric(InteractionVal),
						   as.integer(log2(length(Mob))),
					   colia = as.integer(coliation));
	inteIndex <- as.matrix(InteractionValue$inter);
	coliaIndex <- as.matrix(InteractionValue$colia);
	index <- cbind(inteIndex,coliaIndex); 				
	return (round(index, digits=4));

}
# This is a wrapper function which calls the main computation procedure in C/C++ code.
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
