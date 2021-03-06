\name{gridSearch}
\alias{gridSearch}
\title{Evaluate an objective function for a number of pre-defined parameter sets}
\usage{
gridSearch(p, f, ...)
}
\arguments{
  \item{p}{A list defining the parameter sets to be tested.
  Each element of the list should be a numeric vector,
  representing the test values of a particular parameter.
  List elements must be named. The names are passed as the
  parameters' names to \code{f}.}

  \item{f}{Objective function with interface
  \code{f(par,...)}.  The 1st argument of this function
  must be a numeric vector holding the parameters. When
  \code{f} is called, the names of the elements in
  \code{par} are copied from the names of the elements in
  argument \code{p}. The return value of \code{f} should be
  a \emph{named} vector (which can be of length 1).}

  \item{...}{Additional arguments to be passed to the
  objective function \code{f}.}
}
\value{
A list with two components: \item{params}{A data frame
holding all tested parameter sets. The column names are
identical to the names of \code{p}.} \item{errors}{A list
whose length equals the number of tested parameter sets.
The list element with index k holds the return value of
\code{f} for the parameter set stored in the k-th row of
the returned data frame \code{params}. The
\code{\link{lapply}} method is suitable for extracting
values from the list.}
}
\description{
The method evaluates an objective function for a fixed
number of parameter sets. The parameter sets are generating
by building all possible combinations of the test-values
supplied for the individual parameters.
}
\examples{
# Approximate the parameters of a parabola y=ax^2+b by simple grid search
x.obs=c(0,1,2)
y.obs=c(0,1,4)
objfun= function(p, x.obs, y.obs) {
  c(sse= sum(((p["a"]*x.obs^2+p["b"]) - y.obs)^2))
}
p= list(a=seq(-1,1,0.1), b=seq(-1,1,0.1))
res= gridSearch(p=p, f=objfun, x.obs=x.obs, y.obs=y.obs)
sse= unlist(lapply(X=res$errors, FUN=function(z) { z[["sse"]] }))
print(res$params[which.min(sse),])
}
\author{
David Kneis \email{david.kneis@uni-potsdam.de}
}
\seealso{
Use \code{\link{mcs_run}} which uses random parameter sets
instead of pre-defined ones.
}

