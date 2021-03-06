\name{flowdir}
\alias{flowdir}
\title{Flow directions on a digital elevation model (DEM)}
\usage{
  flowdir(grid, silent = TRUE)
}
\arguments{
  \item{grid}{The \emph{sink-filled} DEM as an object of
  class geogrid. It is important that sinks have been
  filled before, e.g. using \code{\link{sinkfill}}.}

  \item{silent}{Print status info? (logical)}
}
\value{
  A geogrid of flow direction codes (as integers). See
  notes.
}
\description{
  For each cell, the flow direction is encoded as an
  integer in range 1 to 8. Code 1 means North-West and the
  code increases in clock-wise direction, thus 2= North, 3=
  North-East, 4= East and so on. If the drainage direction
  of a cell is undefined, a code of 0 is assigned to that
  cell. This happens in the case of (1) sinks, (2) missing
  elevation data in the surrounding of a cell, and (3) flat
  regions at the margings of the DEM. Note that flat areas
  in central part of the DEM are handled (by allowing cells
  to drain into near drained cells).
}
\note{
  Undefined values in the input DEM are passed on to the
  output. The corresponding nodata value in the output grid
  is -9999.
}
\examples{
dem= geogrid(matrix(runif(6*8), ncol=8, nrow=6, byrow=TRUE),
  xllcorner=0, yllcorner=0, cellsize=1, nodata=-9999)
fdir= flowdir(dem)
geogrid.plot(fdir,"Flow dir. codes")
}
\author{
  David Kneis \email{david.kneis@uni-potsdam.de}
}

