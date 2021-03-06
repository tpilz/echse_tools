\name{geogrid.valuesAtPoints}
\alias{geogrid.valuesAtPoints}
\title{Extract values from a geogrid}
\usage{
  geogrid.valuesAtPoints(grid, xy_table, silent = TRUE)
}
\arguments{
  \item{grid}{A geogrid object.}

  \item{xy_table}{A data frame defining the sampling
  points. There must be at least two columns named 'x' and
  'y'.}

  \item{silent}{Print status info? (logical)}
}
\value{
  A numeric vector whose length is the number rows in
  \code{xy_table}.  For sampling points being located
  outside the grid's extension, the grid's \emph{nodata}
  value (i.e. \code{grid$nodata_value}) is returned.
}
\description{
  The function returns the values of a geogrid's matrix
  corresponding to a set of locations.
}
\examples{
# A sample grid
g= geogrid(m=matrix(1:9, ncol=3, nrow=3, byrow=TRUE),
  xllcorner=0, yllcorner=0, cellsize=1, nodata_value=-9999)
p= data.frame(x= c(0.5,2.5), y= c(0.5,2.5))
print(geogrid.valuesAtPoints(g,p))
}
\author{
  David Kneis \email{david.kneis@uni-potsdam.de}
}

