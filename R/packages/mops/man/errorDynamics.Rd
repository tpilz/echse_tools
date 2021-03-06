\name{errorDynamics}
\alias{errorDynamics}
\title{Temporal analysis of model error}
\usage{
errorDynamics(obs_file, obs_colTime, obs_colValue, obs_colsep = "\\t",
  obs_timeConv = function(x) {     as.POSIXct(strptime(x,
  "\%Y-\%m-\%d \%H:\%M:\%S", tz = "UTC"), tz = "UTC") }, sim_file, sim_colTime,
  sim_colValue, sim_colsep = "\\t", sim_timeConv = function(x) {    
  as.POSIXct(strptime(x, "\%Y-\%m-\%d \%H:\%M:\%S", tz = "UTC"), tz = "UTC") },
  obs_nodata = -9999, periods.select = data.frame(begin = c(), end = c()),
  periods.ignore = data.frame(begin = c(), end = c()),
  gof_function = function(obs, sim) {     c(nPairs = length(obs), pBias =
  (sum(sim) - sum(obs))/sum(obs) * 100, NSE = 1 - mean((obs - sim)^2)/var(obs))
  })
}
\arguments{
  \item{obs_colTime}{Column in table \code{observed}
  holding time information.}

  \item{sim_colsep}{Column separator used in
  \code{sim_file}. Defaults to TAB.}

  \item{sim_timeConv}{A function to convert the strings in
  column \code{sim_colTime} of \code{sim_file}. See
  argument \code{timeConv} of the
  \code{\link{read_timeSeries}} method for details.}

  \item{periods.select}{A data frame with a set of temporal
  filter rules being applied to the time series. See the
  \code{periods.select} argument of the
  \code{\link{read_timeSeries}} method for details.}

  \item{periods.ignore}{A data frame with a set of temporal
  filter rules being applied to the time series. See the
  \code{periods.ignore} argument of the
  \code{\link{read_timeSeries}} method for details.}

  \item{gof_function}{An objective function of the form
  'f(obs,sim)' which returns the goodness-of-fit based on
  the vectors of observed (obs) and simulated data (sim),
  respectively. In the context of optimization, it should
  return a scalar result (see the documentation of the
  \code{\link{optim}} method). If the result is not a
  scalar, it should be a vector, preferrably with names.}

  \item{obs_file}{Name of the file containing the time
  series of observations.}

  \item{obs_colValue}{Name of column in \code{obs_file}
  containing the data.}

  \item{obs_colsep}{Column separator used in
  \code{obs_file}. Defaults to TAB.}

  \item{obs_timeConv}{A function to convert the strings in
  column \code{obs_colTime} of \code{obs_file}. See
  argument \code{timeConv} of the
  \code{\link{read_timeSeries}} method for details.}

  \item{sim_file}{Name of the file containing the simulated
  time series.}

  \item{sim_colTime}{Name of column in \code{sim_file}
  containing time info.}

  \item{sim_colValue}{Name of column in \code{sim_file}
  containing the data.}

  \item{obs_nodata}{A value which indicates missing or
  corrupt data in the time series of observations. Often
  used values are -9999 or \code{NA}.}
}
\value{
A list of data frames holding the computed results.
}
\description{
The function analyzes the error of a simulation separately
for temporal subsets, currently years and months.
}
\note{
Although one can use this function to plot data of
different resolution (hourly simulation and daily
observations, for example), the computed goodness-of-fit is
based on records with identical time stamps (only).
}
\author{
David Kneis \email{david.kneis@uni-potsdam.de}
}

