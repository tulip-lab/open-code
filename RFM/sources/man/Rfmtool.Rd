\name{Rfmtool}
\alias{Rfmtool}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Rfmtool package
}
\description{
Programming library of fuzzy measure which provides various tools for handling fuzzy measures, 
calculating Shapley value and Interaction index, Choquet integrals, 
as well as fitting fuzzy measures to empirical data.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
fm.fitting(data, kadd): this estimates the fuzzy measure based on the empirical data. 

fm.Choquet(x, v): this calculates the Choquet Integral based on the general fuzzy measure.

fm.ChoquetMob(x, Mob): this calculates the Choquet Integral based on the Mobius fuzzy measure.

fm.Mobius(v): transforms the general fuzzy measure v into the Mobius representation.

fm.Zeta(Mob): transforms the Mobius fuzzy measure Mob to the general representation.

fm.Shapley(v): calculates the Shapley value from the general fuzzy measure v.

fm.Interaction(Mob): calculates the Interaction Index from the Mobius fuzzy
measure Mob.

}
%- maybe also 'usage' for other objects documented here.
\details{For more detail about the usage of each function.
Please use the following command in the R environment.

help(fm.fitting)

help(fm.Choquet)

help(fm.ChoquetMob)

help(fm.Mobius)

help(fm.Zeta)

help(fm.Shapley)

help(fm.Interaction)

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
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
