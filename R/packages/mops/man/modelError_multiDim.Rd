\name{modelError_multiDim}
\alias{modelError_multiDim}
\title{Compute the error of a dynamic model simulation for a given set of parameters}
\usage{
modelError_multiDim(parameters, model_path, model_args, func_first,
  moreArgs_first = NULL, func_final, moreArgs_final = NULL, observed,
  obs_colTime, sim_files, sim_colsTime, sim_colsValue, sim_colsep = "\\t",
  sim_timeConv = function(x) {     as.POSIXct(strptime(x,
  "\%Y-\%m-\%d \%H:\%M:\%S", tz = "UTC"), tz = "UTC") },
  periods.select = data.frame(begin = c(), end = c()),
  periods.ignore = data.frame(begin = c(), end = c()),
  gof_function = function(obs, sim) {     mean((obs - sim)^2) },
  unlist = FALSE, stopIfNoData = TRUE)
}
\arguments{
  \item{parameters}{A \emph{named} vector holding the
  values of the parameters to be used in the model call.
  Note that necessary changes to the model's input file(s)
  are \emph{NOT} performed automagically. Any of those
  changes need to be done by the user-specified function
  \code{func_first} (see below).}

  \item{func_first}{An external function to be called at
  the very beginning of the current function.  It is called
  as \code{f(parameters, moreArgs_first)} where
  \code{parameters} is the parameters vector and
  \code{moreArgs_first} holds any additional arguments.
  Typically, \code{func_first} is responsible for changing
  the model's input files to reflect the current parameter
  set contained in \code{parameters}. This can be achieved,
  for example, by calls to \code{\link{update_template}} or
  similar methods (see examples). Furthermore,
  \code{func_first} often performs an initial clean-up if
  \code{modelError_multiDim} is called repeatedly under
  control of another method (such as \code{\link{optim}},
  for example).  The function should return an integer code
  of 0 to signal successful execution or a non-zero code to
  signal an error.}

  \item{moreArgs_first}{Last argument to be passed to
  \code{func_first}.  Use a list if the function requires
  multiple values as inputs.}

  \item{func_final}{An external function to be called at
  the very end of the current function. It is called as
  \code{f(parameters, gof, moreArgs_final)} where
  \code{gof} is the return value of \code{gof_function}
  (see below).  Further arbitrary arguments can be passed
  via \code{moreArgs_final}.  If \code{modelError_multiDim}
  is called repeatedly under the control of another method,
  \code{func_final} is typically responsible for saving the
  model's output and/or recording the godness-of-fit for
  the tested parameter sets. See argument \code{func_first}
  for possible return values.}

  \item{moreArgs_final}{Last argument to be passed to
  \code{func_final}.  Use a list if multiple values need to
  be passed.}

  \item{observed}{A data frame holding one or more time
  series of observations.  The time column specified as
  \code{obs_colTime} must be of type \code{POSIXct}, other
  columns must be \code{numeric}.  Any Missing values must
  be marked with \code{NA}.}

  \item{obs_colTime}{Column in table \code{observed}
  holding time information.}

  \item{sim_files}{A named vector of file names specifying
  the simulated time series to be compared with observation
  data. Element names must correspond to column names in
  \code{observed}.}

  \item{sim_colsTime}{Vector of the same length as
  \code{sim_files} specifying the names of the columns
  containing time info.}

  \item{sim_colsValue}{Vector of the same length as
  \code{sim_files} specifying the names of the columns
  containing the data.}

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

  \item{unlist}{If \code{TRUE}, the \code{\link{unlist}}
  method is applied to the return value. Default is
  \code{FALSE}.}

  \item{stopIfNoData}{If \code{TRUE}, an error is generate
  if no corresponding observed and simulated data are
  found. If \code{FALSE}, the function \code{gof_function}
  is called as usual but both arguments are vectors of zero
  length, thus, \code{gof_function} must handle this
  special case.}

  \item{model_path}{Path of the model executable. Note that
  the executable is executed in R's current working
  directory, i.e. the one returned by \code{\link{getwd}}.
  This is true even if the executable resides somewhere
  else.}

  \item{model_args}{A \emph{named} vector of command line
  arguments to be passed to the model. Note that, for named
  elements, name and value are concatenated by '=',
  automatically. Moreover, all values are enclosed in shell
  quotes (using \code{\link{shQuote}}). For example, a
  vector \code{c(a='1', '-x', b='2')} is expanded to the
  string 'a='1' '-x' b='2''.}
}
\value{
By default, a list of the same length (and with the same
names) as vector \code{files_sim}.  Each list element holds
the return value of \code{gof_function} applied to the time
series of simulated and observed values. If the
\code{unlist} argument is \code{TRUE}, the list is
converted into a vector (using the \code{\link{unlist}}
method).
}
\description{
The function calls a dynamic simulation model (an external
executable) with a given set of model parameters. It then
computes measure(s) of the model error by comparing
simulated and observed time series. The function takes the
vector of model parameters as the first argument, hence it
can be used as an objective function in R's optimization
method \code{\link{optim}}.
}
\note{
For 1-dimensional optimization using R's
\code{\link{optimize}} method, use
\code{\link{modelError_oneDim}} which is a convenient
wrapper for \code{modelError_multiDim}.
}
\examples{
\dontrun{

# Example for 'func_first' that updates parameter values in a single file
updatePars_byTemplate= function(p, args) {
  stopifnot(all(c("fileTemplate","fileResult","charOpen","charClose")
    \%in\% names(args)))
  n= update_template(file_template=args$fileTemplate, vect_updates=p,
    char_open=args$charOpen, char_close=args$charClose,
    file_result=args$fileResult, overwrite=TRUE)
  if (n == 0)
    stop(paste("Updating of '",args$fileTemplate,"' failed.",sep=""))
}

# Example for 'func_first' that updates parameter values in multiple files
updatePars_byTemplates= function(p, args) {
  stopifnot(all(c("filesTable","charOpen","charClose") \%in\% names(args)))
  stopifnot(is.data.frame(args$filesTable),
   all(c("fileTemplate","fileResult") \%in\% names(args$filesTable)))
  for (i in 1:nrow(args$filesTable) {
    n= update_template(file_template=args$filesTable$fileTemplate[i],
      vect_updates=p, char_open=args$charOpen, char_close=args$charClose,
      file_result=args$filesTable$fileResult[i], overwrite=TRUE)
    if (n == 0)
      stop(paste("Updating of '",args$filesTable$fileTemplate[i],
        "' failed.",sep=""))
  }
}

}
}
\author{
David Kneis \email{david.kneis@uni-potsdam.de}
}
\seealso{
\code{\link{modelError_oneDim}} for the 1-dimensional case
}

