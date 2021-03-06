\name{geogrid.writeAscii}
\alias{geogrid.writeAscii}
\title{Export a geogrid object to a file}
\usage{
  geogrid.writeAscii(grid, file, replace = FALSE)
}
\arguments{
  \item{grid}{A geogrid object.}

  \item{file}{Name/path of the result file.}

  \item{replace}{Is is OK to replace an existing output
  file? Defaults to \code{FALSE}.}
}
\value{
  \code{NULL}
}
\description{
  The grid is exported to a file in ESRI's ASCII grid
  format, i.e. there are six header lines with keywords
  'ncols', 'nrows', 'xllcorner', 'yllcorner', 'cellsize',
  and 'nodata_value'. The matrix of values starts at line
  seven.
}
\author{
  David Kneis \email{david.kneis@uni-potsdam.de}
}

