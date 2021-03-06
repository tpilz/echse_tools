\name{xs.extractDEM}
\alias{xs.extractDEM}
\title{Cross-secions from digital elevation models}
\usage{
  xs.extractDEM(filesDEM, filesSHP, minRelResol = 1,
    id_field = "id", zeroBase = TRUE, ndigits = 3,
    outdir = getwd(), prefix = "xs", png = FALSE,
    replace = FALSE, silent = TRUE)
}
\arguments{
  \item{filesDEM}{Vector of file names. Each element should
  point to a file containing elevation data in ESRI's ASCII
  grid format.}

  \item{filesSHP}{Vector of file names. Each element should
  point to an ESRI shape file defining cutline(s) of
  cross-section(s).}

  \item{minRelResol}{Factor to control the minimum
  horizontal resolution (offset spacing) for the extracted
  cross-sections. A value of 1.0 (default) sets the
  distance between adjacent offsets to the cell size of the
  DEM.  Values of 0.5 or 2, for example, reduce or increase
  the spacing by a factor of 2, respectively.}

  \item{id_field}{The ID field in the shape file's
  attribute table. The info in this fielsd is used to
  construct names for the extracted cross-sections.}

  \item{zeroBase}{If \code{TRUE}, the elevation data for
  the individual cross-sections are transformed so that the
  elevation of the lowest point becomes zero. This
  facilitates the visual comparison of cross-sections. If
  \code{FALSE}, the elevation data as extracted from the
  DEM are retained.}

  \item{ndigits}{Desired number of digits in
  \emph{horizontal} coordinates, i.e.  offsets, x- and
  y-coordinates. The precision of vertical coordinates is
  determined by the original DEM data and is \emph{not}
  affected by this argument.}

  \item{outdir}{Name of the directory for output files.}

  \item{prefix}{Prefix used in the construction of file
  names. For each cross-section, the file name is obtained
  by concatenating this prefix with the cutline's ID. A
  suitable file name suffix is appended.}

  \item{png}{Switch to turn the output of graphics files on
  (\code{TRUE}) or off.}

  \item{replace}{If \code{TRUE}, existing files will be
  silently replaced.}

  \item{silent}{If \code{TRUE}, some diagnostic messages
  are printed.}
}
\value{
  The total number of extracted cross-sections (integer).
}
\description{
  The function extracts cross-sections from a digital
  elevation model. The cross-sections are defined by their
  cutlines on the \emph{horizontal} earth's surface.
  Multiple DEMs can be processed in a single call.
}
\note{
  If a cutline consists of more than two points, the
  interior points are ignored and the straight connection
  of the end points is used as the cutline.
}
\author{
  David Kneis \email{david.kneis@uni-potsdam.de}
}
\seealso{
  \code{\link{geogrid.valuesAtPoints}},
  \code{\link{lineShapeAsTable}}
}

