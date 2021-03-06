\name{visEval}
\alias{visEval}
\title{Simple visualization function for manual model calibration}
\usage{
visEval(sim_file, sim_colTime, sim_colValue, sim_colsep = "\\t",
  sim_timeConv = function(x) {     as.POSIXct(strptime(x,
  "\%Y-\%m-\%d \%H:\%M:\%S", tz = "UTC"), tz = "UTC") }, obs_file, obs_colTime,
  obs_colValue, obs_colsep = "\\t", obs_timeConv = function(x) {    
  as.POSIXct(strptime(x, "\%Y-\%m-\%d \%H:\%M:\%S", tz = "UTC"), tz = "UTC") },
  obs_nodata = -9999, selection_file, selection_colsep = "\\t",
  selection_timeConv = function(x) {     as.POSIXct(strptime(x,
  "\%Y-\%m-\%d \%H:\%M:\%S", tz = "UTC"), tz = "UTC") }, fac_ymin = 0,
  fac_ymax = 1.25, prefix = "visEval")
}
\arguments{
  \item{sim_file}{Name of the file containing the simulated
  time series.}

  \item{sim_colTime}{Name of column in \code{sim_file}
  containing time info.}

  \item{sim_colValue}{Name of column in \code{sim_file}
  containing the data.}

  \item{obs_file}{Name of the file containing the time
  series of observations.}

  \item{obs_colTime}{Name of column in \code{obs_file}
  containing time info.}

  \item{obs_colValue}{Name of column in \code{obs_file}
  containing the data.}

  \item{obs_colsep}{Column separator used in
  \code{obs_file}. Defaults to TAB.}

  \item{obs_timeConv}{A function to convert the strings in
  column \code{obs_colTime} of \code{obs_file}. See
  argument \code{timeConv} of the
  \code{\link{read_timeSeries}} method for details.}

  \item{obs_nodata}{A value which indicates missing or
  corrupt data in the time series of observations. Often
  used values are -9999 or \code{NA}.}

  \item{selection_file}{Name of a file containing the
  specification of periods of interest. The file should
  contain three columns named 'id', 'from', and 'until'.
  Identifiers for the data selections are expected in the
  'id' field. Those values are treated as character
  strings. The entries in the 'from' and 'until' columns
  control which records of the observed and simulated data
  contribute to a particular data selection. The entries in
  these fields must be convertable to class POSIXct (see
  \code{selection_timeConv}).  A data selection may
  comprise multiple separate periods of time, thus the
  total number of data selections is equal to the number of
  unique values in the 'id' field.}

  \item{selection_colsep}{The column separator used in
  \code{selection_file}.}

  \item{selection_timeConv}{A function to convert the data
  in the 'from' and 'until' columns of
  \code{selection_file} into values of class
  \code{POSIXct}. See argument \code{obs_timeConv} of
  method \code{prefix{modelEvaluationTable}} for details.}

  \item{fac_ymin}{A factor by which the minimum of the
  observed data is multiplied when setting the lower limit
  of the y-axis. Default is 0.}

  \item{fac_ymax}{Like \code{fac_ymax} but for the upper
  limit of the y-axis.  Default is 1 + 1/4.}

  \item{prefix}{A string used as the initial part of the
  output file name.}

  \item{sim_colsep}{Column separator used in
  \code{sim_file}. Defaults to TAB.}

  \item{sim_timeConv}{A function to convert the strings in
  column \code{sim_colTime} of \code{sim_file}. See
  argument \code{timeConv} of the
  \code{\link{read_timeSeries}} method for details.}
}
\value{
Name of a PDF file for the created plots. The file name is
generated automatically from the system time and the string
in \code{prefix}. The file is created in the current
working directory.
}
\description{
The function plots the simulation results for selected data
groups and periods of time. Scaling of the plots is
determined by the observation data only to facilitate
visual comparison with alternative simulation outputs.
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

