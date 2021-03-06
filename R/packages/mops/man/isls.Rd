\name{isls}
\alias{isls}
\title{Improved step-wise line search algorithm}
\usage{
isls(p, f, ..., steps, suspend = 0, lower = rep(-Inf, length(p)),
  upper = rep(Inf, length(p)), maxiter = 10 * length(p)^2)
}
\arguments{
  \item{p}{A numeric vector holding the initial values of
  the parameters.  Elements must be named.}

  \item{f}{The objective function to be minimized. If
  \code{f} returns a vector, minimization is done with
  respect to the first element of the return value. See
  details below.}

  \item{...}{Arguments other than \code{p} to be passed to
  \code{f}. See details below.}

  \item{steps}{A vector with the same length as \code{p}
  defining absolute step sizes for variation for the
  individual parameters. In each iteration, a particular
  parameter with index \code{i} is varied between
  \code{p[i]+steps[i]} and \code{p[i]-steps[i]} in order to
  test for a reduction (or rise) of \code{f}.}

  \item{suspend}{The number of iterations for which an
  element of \code{p} is excluded from further optimization
  after being identified as insensitive. The default is
  \code{suspend=0}, i.e. optimization is attempted in every
  iteration irrespective of a sensitivity. Higher values
  may speed up the optimization if (locally) non-sensitive
  parameters are present.}

  \item{lower}{Lower limits for the parameters. Must be of
  the same length as \code{p}.}

  \item{upper}{Upper limits for the parameters. Must be of
  the same length as \code{p}.}

  \item{maxiter}{The maximum number of iterations.}
}
\value{
A list with the following components \item{opt.p}{The
'best' parameter vector found with the method.}
\item{opt.f}{The value of \code{f} corresponding to the
'best' parameter set.} \item{opt.iter}{The iteration index
corresponding to \code{opt.f}. The index 0 corresponds to
the evaluation of \code{f} for the initial values of
\code{p}, i.e.  this is not considered as an iteration.}
\item{opt.eval}{Index of the function evaluation
corresponding to \code{opt.f}.  The index 1 corresponds to
the evaluation of \code{f} for the initial values of
\code{p}.} \item{niter}{The total number of iterations
used.} \item{neval}{The total number of evaluations of
\code{f}.} \item{convergence}{A logical value. Set to
\code{FALSE} if the algorithm failed to detect a
\emph{local} minimum (or maximum) of \code{f} within no
more than \code{maxiter} iterations. Otherwise
\code{TRUE}.} \item{trace_p}{A data frame with as many
columns as there are elements in \code{p}. The first row
lists the initial values and the subsequent rows hold the
new parameter values after each iteration. The total number
of rows is \code{niter}+1.} \item{trace_f}{A data frame
with as many columns as there are elements in the return
value of \code{f}. The first row lists the value(s) of
\code{f} evaluated for the initial parameter values.  The
subsequent rows hold the 'optimum' values of \code{f}
obtained in each iteration (optimality refers to the 1st
element of \code{f} only; see below).  The total number of
rows is \code{niter}+1.}
}
\description{
This is a simple \emph{deterministic} algorithm to fit the
parameters of a model. It was desinged for cases where
'good' initial estimates of the parameters are available.
The algorithm is supposed to be useful in the optimization
of computationally expensive, multi-parameter models where
classical methods may be too fragile and stochatic methods
may consume too much computer time. See the below-mentioned
reference for details on the original algorithm. This
version includes a number of improvements over the original
version.
}
\note{
The objective function is called as \code{f(p,...)}. It
must return either a scalar result or a numeric vector,
preferably named. In the vector case, minimization is
carried out with respect to the first element only but
values of the additional elements are reported in
\code{trace_f}.  Errors occuring within \code{f} may be
signaled by a non-finite return value (first element, if it
is a vector). In this case, an appropriate error message is
generated which includes the recently tested parameter
values.  Note that proper rounding of the result of
\code{f}, e.g. using \code{signif} may help to avoid
problems with minor local minima (or maxima).

The success of this method is sensitive to the chosen step
sizes and the initial estimates for the parameters. See the
referenced paper for potential uses and pitfalls.

Note that the result may also be sensitive to the order of
the elements in vector \code{p}. It might be useful to put
sensitive parameters first and to put less sensitive ones
at positions with higher element indices. There is no
established recommendation, however.

In the case of known parameter interactions (or constraints
applying to parameter combinations) it may be useful to
introduce artificial parameters.  If, for example, two
parameters \eqn{a} and \eqn{b} are known to be corellated
in a linear way, one could substitute \eqn{b} by a new
parameter \emph{c} being defined as \eqn{b= a * c}.

It is recommended to check the \code{convergence} component
of the returned list before using the estimated parameters.
Note that the parameter estimates may be 'bad' even though
convergence is signalled. This may happen, in particular,
for objective functions with many local minima (maxima) and
in the case of badly chosen initial values and/or step
sizes.
}
\examples{
# Estimate parameters of a linear model
model= function(params, prtors) prtors * params["a"] + params["b"]
err= function(x,y) { c(rmse= sqrt(mean((x - y)^2)), bias=mean(x-y)) }
objFun= function(params, model, prtors, obsrv) err(model(params,prtors), obsrv)
params= c(a=1, b=0)  # True parameters
prtors= 1:1000       # Predictors (x-values)
# Generate noisy data (y-values) being compatible with the model
obsrv= model(params=params, prtors=prtors) +
  model(params=params, prtors=prtors) * rnorm(length(prtors), mean=0, sd=1)
# Optimize initial guess
params_ini= c(a=2, b=50)
opt= isls(p=params_ini, f=objFun, model=model, prtors=prtors, obsrv=obsrv,
  steps=c(0.01,1), maxiter=1000)
# Check result
if (!opt$convergence) stop("No convergence within max. number of iterations.")
layout(matrix(1:4,ncol=2,byrow=TRUE))
plot(prtors,obsrv, col="grey")
lines(prtors, model(params=params,prtors=prtors), col="blue")
lines(prtors, model(params=params_ini,prtors=prtors), col="red", lty=2)
lines(prtors, model(params=opt$opt.p,prtors=prtors), col="red")
legend("topleft",bty="n",lty=c(1,2,1),col=c("blue","red","red"),
  legend=c("True parameters","Initial guess","SLS estimate"))
plot(1:(opt$niter+1),opt$trace_f[,1],xlab="Iteration",ylab=names(opt$trace_f)[1])
plot(1:(opt$niter+1),opt$trace_p$a,xlab="Iteration",ylab="Parameter a")
plot(1:(opt$niter+1),opt$trace_p$b,xlab="Iteration",ylab="Parameter b")
}
\author{
David Kneis \email{david.kneis@uni-potsdam.de}
}
\references{
The original algorithm was presented by V. Kuzmin et al.
(2008), doi:10.1016/j.jhydrol.2008.02.001
}

