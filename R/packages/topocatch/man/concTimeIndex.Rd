\name{concTimeIndex}
\alias{concTimeIndex}
\title{Concentration time index derived from DEM}
\usage{
  concTimeIndex(grid_dem, grid_flowdir, grid_flowacc,
    crit_source_area, dz_min = 0.1, silent = TRUE)
}
\arguments{
  \item{grid_dem}{A geogrid object representing the
  \emph{sink-filled} digital elevation model as output by
  \code{\link{sinkfill}}.}

  \item{grid_flowdir}{A geogrid object holding flow
  direction codes which correspond to the elevation model
  as output by \code{\link{flowdir}}.}

  \item{grid_flowacc}{A geogrid object with flow
  accumulation values corresponding to the elevation model
  as output by \code{\link{flowacc}}.}

  \item{crit_source_area}{A numeric value defining the
  critical source area (CSA). Streams are assumed to form
  in cells with a catchment whose areal extent is >= the
  CSA value. Should be several times larger than the extent
  of a single grid cell.}

  \item{dz_min}{A small numeric value > 0 representing a
  minimum elevation difference between adjacent cells of
  the elevation model. It prevents the slope and thus the
  CTI to become infinite in flat areas. Defaults to 0.1.}

  \item{silent}{Print status info? (logical)}
}
\value{
  A geogrid of CTI values.
}
\description{
  The concentration time index (CTI) is a simple
  DEM-derived measure of the travel time of runoff. For a
  grid cell of the elevation model, the CTI is defined as
  \eqn{CTI = \sum_{k=1}^{n} X_k / \sqrt{I_k}} where \eqn{X}
  is the length of a flow path segment, \eqn{i} is the
  slope of that segment, and \eqn{n} is the total number of
  segments in the flow path (i.e. the number of cells
  through which water must flow until it reaches a stream.
  The CTI of a cell is small if the flow path to is short
  (small distance to stream) and the average slope along
  the flow path is high. The term \eqn{\sqrt{I_k}}
  originates from Manning's equation. The density of the
  stream network is controlled by the critical source area
  (CSA).
}
\note{
  Undefined CTI values (due to undefined cells in the DEM
  or the grid of flow direction) are set to -9999.
}
\examples{
# Create a simple DEM
dem_raw= geogrid(m=matrix(c(
    5,5,5,5,5,5,5,5,
    5,4,4,4,4,4,4,5,
    5,4,3,3,3,3,4,5,
    5,4,3,2,2,3,4,5,
    5,4,3,2,2,3,4,5,
    5,4,3,1,1,3,4,5
  ), ncol=8, nrow=6, byrow=TRUE),
  xllcorner=0, yllcorner=0, cellsize=1, nodata_value=-9999)
dem= sinkfill(grid=dem_raw, ndigits=0, silent=FALSE)
fdir= flowdir(grid=dem)
facc= flowacc(grid=fdir)
cti= concTimeIndex(dem, fdir, facc, crit_source_area=2, dz_min=0.1)
geogrid.plot(cti, "CT index")
}
\author{
  David Kneis \email{david.kneis@uni-potsdam.de}
}

