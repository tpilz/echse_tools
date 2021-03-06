\name{xs.geoFuncs}
\alias{xs.geoFuncs}
\title{Basic hydraulic properties of a river cross-section}
\usage{
  xs.geoFuncs(offsets, elevations,
    WSE = seq(from = min(elevations), to = max(elevations), length.out = 5))
}
\arguments{
  \item{offsets}{A numeric vector of offsets. Typically,
  these are horizontal distances measured from a fixed
  point at one of the river banks. It does not matter
  whether the fix point is at the left or right bank.}

  \item{elevations}{A numeric vector of elevations
  corresponding to the offsets in \code{offsets}. These can
  be absolute elevations (m a.s.l.) or vertical distances
  to any other convenient reference elevation.}

  \item{WSE}{A vector of water surface elevations for which
  wet area and wet parameter are to be computed. These
  values are typically within \code{range{elevations}}.}
}
\value{
  A list with the following components, each being a vector
  of \code{length(WSE)}.  \item{WSE}{The input vector
  \code{WSE}.} \item{area}{Values of wet cross-section
  area.} \item{peri}{Values of wer perimeter.}
  \item{rhyd}{Values of hydraulic radius.}
}
\description{
  The function returns values of the wet area, wet
  perimeter, and hydraulic radius of a cross-section
  corresponding to a vector of given water surface
  elevations (WSE).
}
\note{
  For values in \code{WSE} being smaller than
  \code{min(elevations)}, all cross-section characteristics
  are zero. For values that exceede \code{max(elevations)},
  the function returns valid results assuming vertical
  boundaries at the smallest and largest offset,
  respectively.
}
\examples{
# Generate cross-section data
geo= data.frame(x= 0:5, z= c(2,1.5,0.5,0.5,1.5,2))
wsElevs= seq(from=0.5, to=1.75, by=0.25)
hydrProp= xs.geoFuncs(offsets=geo$x, elevations=geo$z, WSE=wsElevs)
plot(geo$x, geo$z, type="l", xlab="offset", ylab="elevation", asp=1)
abline(h=wsElevs, lty=3)
print(as.data.frame(hydrProp))
}
\author{
  David Kneis \email{david.kneis@uni-potsdam.de}
}

