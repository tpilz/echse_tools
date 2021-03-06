\name{crps_hersbach}
\alias{crps_hersbach}
\title{CRPS of a forecast (ensemble) of a continuous variable}
\usage{
crps_hersbach(obs, fct)
}
\arguments{
  \item{obs}{Vector of observations of length m (m being
  the number of cases).}

  \item{fct}{Matrix holding predicted values corresponding
  to \code{obs}. There must be as many rows as there are
  elements in \code{obs}. For a deterministic forecast, the
  matrix has a single column only. In the case of an
  ensemble forecast, each column represents a member.}
}
\value{
For compatibility with the 'crps' function from the
verification package, a list with two components is
returned: \item{crps}{The computed crps for each single
case (vector).} \item{CRPS}{The crps averaged over all
cases (scalar).}
}
\description{
The function computes the continous ranked probability
score (CRPS) for an ensemble (or deterministic) forecast of
a continous variable.
}
\examples{
\dontrun{
Compare with the function 'crps' from package 'verification'. This function
doesn't use the values of the individual members but only mean and standard
deviation of the forecasts.

Generate observations
ncases= 1000
obs= runif(ncases)
# Generate mean and sdevs of enemble forecasts
fct_means= runif(ncases)
fct_sdevs= runif(ncases)
# Generate ensemble forecasts with choosen mean and sdev
nmembs= 20
fct= matrix(NA, nrow=ncases, ncol=nmembs)
for (i in 1:ncases) {
  # Draw a perfect (non-random) sample from the normal distribution
  fct[i,]= qnorm(p=seq(from=0.01, to=0.99, length.out=nmembs),
    mean=fct_means[i], sd=fct_sdevs[i])
}
# Compute crps using the discrete member values
ver1= crps_hersbach(obs, fct)
# Compute crps using only mean and sdev
require(verification)
ver2= crps(obs, cbind(fct_means, fct_sdevs))
# Compare
plot(ver1$crps, ver2$crps, col="grey")
points(ver1$CRPS, ver2$CRPS, pch=20, col="black")
abline(0,1)
}
}
\author{
David Kneis \email{david.kneis@uni-potsdam.de}
}
\references{
Hersbach, H. (2000): Decomposition of the Continuous Ranked
Probability Score for Ensemble Prediction Systems; Weather
and forecasting, Vol. 15, pages 559-570 (used Eqn.s 5, 24,
25, 26, 27, and info from text at page 563)
}

