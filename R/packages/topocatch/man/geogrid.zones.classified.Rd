\name{geogrid.zones.classified}
\alias{geogrid.zones.classified}
\title{Zonal statistics for a grid of classified data}
\usage{
  geogrid.zones.classified(grid_zones, grid_data,
    minCoverage = 1, minShare = 0,
    keepClasses = numeric(0), prefix = "class_",
    reportArea = TRUE, hideZeroFields = FALSE, ndigits = 2,
    silent = TRUE)
}
\arguments{
  \item{grid_zones}{A geogrid object defining the zones.
  The values in this grid should be integers.}

  \item{grid_data}{A geogrid object whose data represent
  classes (of land use, for example). The extend and
  resolution of this grid must be the same as for
  \code{grid_zones}.}

  \item{minCoverage}{A numeric value specifying the minimum
  coverage of the valid grid cells in \code{grid_zones} by
  the valid values in \code{grid_data}. The value must be
  in range \eqn{0 < minCoverage <= 1}.  If the actual
  coverage is less than the value of \code{minCoverage}, a
  warning is generated. Note that the coverage is analyzed
  globally but not for the individual zones.}

  \item{minShare}{A threshold value >= 0 and <= 1. If the
  areal share of a class in a particular zone is less than
  this, the areal share is set to zero, i.e. the class is
  'dissolved'. However, this is not done if (1) the class
  is listed in the argument \code{keepClasses} or (2) the
  class is the one with the largest areal share in the
  particular zone.  One can set \code{minShare} to 1 in
  order to keep the dominating class only.}

  \item{keepClasses}{A vector of integers representing
  classes in the input grid \code{grid_data}. The areal
  share of those classes is never set to zero even if it is
  less than \code{minShare}.}

  \item{prefix}{A character string used as a prefix when
  creating column names for the output table. Must not be
  empty and must be compatible with R's convention for
  names. See the return value for details.}

  \item{reportArea}{Defaults to \code{TRUE}. If
  \code{FALSE}, the total area of the zones is omitted in
  the result table.}

  \item{hideZeroFields}{Defaults to \code{FALSE}. If
  \code{TRUE}, columns containing nothing but zero-values
  are deleted from the result table.}

  \item{ndigits}{The number of digits when rounding the
  results. Should be an integer >= 1.}

  \item{silent}{Print diagnostic messages? (logical)}
}
\value{
  A data frame with columns 'id' and as many columns as
  there are classes in \code{grid_data} unless
  \code{hideZeroFields} is \code{TRUE}.  The latter colums
  hold the areal shares of the classes within the zones and
  the column names are created by concatenation of
  \code{prefix} and the class' integer code.  If
  \code{reportArea} is \code{TRUE}, there will be an
  additional field 'area' holding the total area covered by
  the zones. It can be used, for example, to re-convert the
  areal shares into areas.
}
\description{
  The function expects two input grids, one with integers
  representing classes and another one with integer codes
  defining zones (classes). For each unique zone, the
  shares of the (spatially) corresponding classes computed.
  The function can be used, for example, to compute the
  areal fractions of different land use classes for river
  basins.
}
\author{
  David Kneis \email{david.kneis@uni-potsdam.de}
}

