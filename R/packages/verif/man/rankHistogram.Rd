\name{rankHistogram}
\alias{rankHistogram}
\title{Rank histogram for an ensemble forecast}
\usage{
rankHistogram(obs, fct, plot = FALSE)
}
\arguments{
  \item{obs}{A numeric vector of observations.}

  \item{fct}{A matrix representing the ensemble forecasts
  to be verified. There must be as many rows in \code{fct}
  as there are elements in vector \code{obs}.  Each column
  of the matrix represents an ensemble member.}

  \item{plot}{If \code{TRUE}, the rank histogram is
  plotted.}
}
\value{
A data frame with the columns 'bin' and 'count'. The number
of bins equals the number of ensemble members + 1. The
'zero bin' counts the number of observed values being less
than the smallest ensemble member.
}
\description{
The rank histrogram is a convenient measure of verification
applicable to ensemble forcasts. It is a measure of how
well the ensemble spread represents the true variability
(uncertainty) of the observations.
}
\note{
The rank histrogram may be interpreted as follows
(\url{http://www.cawcr.gov.au/projects/verification}):

Flat - ensemble spread about right to represent forecast
uncertainty

U-shaped - ensemble spread too small, many observations
falling outside the extremes of the ensemble

Dome-shaped - ensemble spread too large, most observations
falling near the center of the ensemble

Asymmetric - ensemble contains bias

Attention: A flat rank histogram does not necessarily
indicate a good forecast, it only measures whether the
observed probability distribution is well represented by
the ensemble.
}
\examples{
# Forecast and observations draw from same distribution (the perfect case)
nevents=5000
nmembers=20
fct= matrix(runif(nevents*nmembers), ncol=nmembers)
obs= runif(nevents)
rankHistogram(obs=obs,fct=fct,plot=TRUE)
}
\author{
David Kneis \email{david.kneis@uni-potsdam.de}
}
\references{
\url{http://www.cawcr.gov.au/projects/verification};
Hamill, T.M., 2001: Interpretation of rank histograms for
verifying ensemble forecasts. Mon. Wea. Rev., 129, 550-560.
}

