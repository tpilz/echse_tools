\name{mcs_sample}
\alias{mcs_sample}
\title{Sample generation for Monte-Carlo simulation}
\usage{
mcs_sample(ranges_table, n = 100)
}
\arguments{
  \item{ranges_table}{Data frame with 3 columns
  'parameter', 'min', 'max'. Each record defines the name
  and the sampling range for a particular parameter.}

  \item{n}{The number of parameter sets to be generated.}
}
\value{
A data frame with \code{n} rows and as many columns as
there are records in \code{ranges_table}. The column are
named after the parameters.
}
\description{
The function generates a number of random parameter sets
using a latin hypercube algorithm from package 'lhs'. The
underlying distribution is uniform.
}
\note{
If the generated random sets are to be used by a simulation
model, the sampling ranges must be chosen carefully.  In
models with many parameters, a particular value of one
parameter may be incompatible with a particular value of
another parameter. For example, if the sampling range for a
parameter 'minimumCapacity' was 2...10, it would not make
sense to use a sampling range 5...20 for a related
parameter 'maximumCapacity'. If the ranges were defined as
above, it is likely that 'minimumCapacity' >
'maximumCapacity' in some sets. Those cases typically lead
to implausible model outputs or a crash of the model due to
numeric errors.  In addition, one should be aware of the
fact that the initial value(s) of a model's state
variable(s) must be compatible with all possible random
parameter sets. For example, an intial value of 0 for a
state variable 'temperature' would be critical if the
sampling range for a related parameter 'minimumTemperature'
was 5...50.
}
\examples{
mcs_sample(data.frame(parameter=c("a","b"),min=c(1,5),max=c(2,10)), n=10)
}
\author{
David Kneis \email{david.kneis@uni-potsdam.de}
}
\seealso{
Use \code{\link{mcs_run}} to run a Monte-Carlo simulation
using the generated sets.
}

