\name{echse_optimize}
\alias{echse_optimize}
\title{Optimization with ECHSE-based models}
\usage{
echse_optimize(opt_func, opt_args, model_path, model_args, file_cnf, simStart,
  simEnd, outdir, placeholder_openChar = "{", placeholder_closeChar = "}",
  colsep_input = "\\t", filesTable, sim_objectNames, sim_colValue,
  sim_colsep = "\\t", obs_file, obs_colTime, obs_colsep = "\\t",
  obs_timeConv = function(x) {     as.POSIXct(strptime(x,
  "\%Y-\%m-\%d \%H:\%M:\%S", tz = "UTC"), tz = "UTC") }, obs_nodata = -9999,
  evalStart = simStart, evalEnd = simEnd, func_err = function(obs, sim) { 
     sqrt(mean((obs - sim)^2)) }, unlist = FALSE, stopIfNoData = TRUE)
}
\arguments{
  \item{opt_func}{A wrapper for the function that carries
  out the actual optimization. It is called as
  \code{opt_func(f, opt_args)} with \code{f} being the
  objective function and \code{opt_args} containing all
  other inputs, typically in form of a list. The objective
  function \code{f} is expected to take the vector of
  parameters (i.e. multipliers) as the only argument.}

  \item{opt_args}{Data to be passed as the second argument
  to \code{opt_func}.  The necessary contents of this
  argument depends on the nature of \code{opt_func}.}

  \item{file_cnf}{Configuration file of the ECHSE-based
  model. The keywords 'simStart', 'simEnd', and
  'outputDirectory' must \emph{NOT} be present in the file.
  The same is true for the keywords specified in column
  'config_key' of \code{filesTable} and the
  \code{model_args} argument.  This is due to the fact that
  all these values are automatically passed to the model as
  command line arguments.}

  \item{simStart}{Start time of the simulation as a value
  of class \code{POSIXct}.}

  \item{simEnd}{End time of the simulation as a value of
  class \code{POSICct}.}

  \item{outdir}{Name/path of a non-existing directory where
  all outputs are to be stored. An error is generated if
  the attempt to create this folder fails.}

  \item{placeholder_openChar}{Single character to mark the
  begin of a placeholder in the files listed in column
  'file_template' of \code{filesTable}.}

  \item{placeholder_closeChar}{Single character to mark the
  end of a placeholder in the files listed in column
  'file_template' of \code{filesTable}.}

  \item{colsep_input}{Single character used to separate
  columns in the model's input files, including the files
  listed in column 'file_base' of \code{filesTable}.}

  \item{filesTable}{A data frame with columns 'config_key',
  'file_template', and 'file_base'.  Entries in column
  'config_key' must be valid keywords used in the
  configuration data (file or command line) of an
  ECHSE-based model.  Entries in column 'file_template'
  represent the names of template files to be updated via
  the \code{\link{update_template}} method. These files
  must contain placeholders whose names correspond to the
  optimized multipliers ( passed via \code{opt_args}.
  Entries in column 'file_base' must be the names of model
  input files which are to be multiplied by the updated
  templates (using \code{\link{multiplyFiles}}) before they
  are actually read by the model. These files must contain
  numeric data rather than placeholders but, apart from
  that, their formats must be identical to the formats of
  the corresponding template files.}

  \item{sim_objectNames}{Character string representing the
  objects of interest.  The model error is analyzed using
  the model's output for these objects.  In the case of
  classical optimization, this vector will be of length one
  so that \code{func_err} yields a scalar result.}

  \item{evalStart}{A value of class \code{POSIXct} defining
  the start of the time period for which the model error is
  to be analyzed.}

  \item{evalEnd}{A value of class \code{POSIXct} defining
  the end of the time period for which the model error is
  to be analyzed.}

  \item{func_err}{A function with interface
  \code{func_err(obs, sim)} taking as input two vectors of
  observed and simulated values, respectively. It must
  return a scalar measure of the model error if
  \code{opt_func} carries out function minimization.}

  \item{sim_colsep}{Column separator used in
  \code{sim_file}. Defaults to TAB.}

  \item{obs_colTime}{Column in table \code{observed}
  holding time information.}

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

  \item{sim_colValue}{Name of column in \code{sim_file}
  containing the data.}

  \item{obs_file}{Name of the file containing the time
  series of observations.}

  \item{obs_colsep}{Column separator used in
  \code{obs_file}. Defaults to TAB.}

  \item{obs_timeConv}{A function to convert the strings in
  column \code{obs_colTime} of \code{obs_file}. See
  argument \code{timeConv} of the
  \code{\link{read_timeSeries}} method for details.}

  \item{obs_nodata}{A value which indicates missing or
  corrupt data in the time series of observations. Often
  used values are -9999 or \code{NA}.}
}
\value{
The function returns the result value of \code{opt_func}.
}
\description{
The function evaluates and optionally minimizes an
objective function that compares the output of an
ECHSE-based model (single variable at single object) with
observation data. The optimized parameters are
dimensionless multipliers applied to the model's input.
}
\author{
David Kneis \email{david.kneis@uni-potsdam.de}
}

