\name{mcs_run}
\alias{mcs_run}
\title{Monte-Carlo simulation for a dynamic simulation model}
\usage{
mcs_run(sets, updating_table, placeholder_openChar = "{",
  placeholder_closeChar = "}", model_path, model_args, outdir_model,
  outdir_mcs, silent = FALSE)
}
\arguments{
  \item{sets}{A data frame of parameter sets. Use
  \code{\link{mcs_sample}} to generate a suitable data
  frame.}

  \item{updating_table}{A data frame with 2 named columns
  'file_template' and 'file_result'.}

  \item{placeholder_openChar}{See arguments of
  \code{\link{update_template}}.}

  \item{placeholder_closeChar}{See arguments of
  \code{\link{update_template}}.}

  \item{outdir_model}{The directory where the model puts
  \emph{all} of its output files. Must be an existing,
  empty directory.}

  \item{outdir_mcs}{The directory where the results if the
  Monte-Carlo simulation are to be collected. Must be an
  existing, empty directory.}

  \item{silent}{If \code{TRUE}, info on the progress of the
  Monte-Carlo simulation is printed. Default is
  \code{FALSE}.}

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
\code{NULL}
}
\description{
The function runs an external simulation model for each set
in a list of parameter sets. The corresponding model output
is saved to a directory with a unique time stamp. This time
stamp is written to a log file along with the corresponding
values of the parameters (see details below). This log file
provides the link between parameter values and simulation
results which is needed for later analysis.
}
\note{
The log file is created in the directory supplied as
\code{outdir_mcs} and its fixed name is 'mcs.log'. Its
contains a table with the time stamp in the first column.
The remaining \code{nrow(ranges_table)} columns hold the
values of the parameters.

In many cases, care must be taken when chosing the
parameter ranges (see argument \code{ranges_table}). In
models with many parameters, a particular value of one
parameter may be incompatible with a particular value of
another parameter. This must be taken into account when
defining the sampling ranges for the two parameters. For
example, if the sampling range for a parameter
'minimumCapacity' was 2...10, it would not make sense to
use a sampling range 5...20 for a related parameter
'maximumCapacity'. If the ranges were defined as above, it
is likely that 'minimumCapacity' > 'maximumCapacity' in
some parameter sets. Those cases typically lead to
implausible model outputs or a crash of the model due to
numeric errors.  In addition, one should be aware of the
fact that the initial value(s) of the model's state
variable(s) must be compatible with all possible random
parameter sets. For example, an intial value of 0 for a
state variable 'temperature' would be critical if the
sampling range for a related parameter 'minimumTemperature'
was 5...50.
}
\author{
David Kneis \email{david.kneis@uni-potsdam.de}
}
\seealso{
Use \code{\link{mcs_eval}} to analyze the output.
}

