\name{assignGages}
\alias{assignGages}
\title{Identify all objects affecting a particular object}
\usage{
  assignGages(tab_objDecl, tab_objLink, gageObjects)
}
\arguments{
  \item{tab_objDecl}{A data frame representing an object
  declaration table.  Such a data frame must contain (at
  least) the two columns 'object' and 'objectGroup'.  The
  \code{\link{hydroModelData}} method returns a suitable
  input (see its \code{fileObjDecl} argument).}

  \item{tab_objLink}{A data frame representing an object
  linkage table.  Such a data frame must contain (at least)
  the five columns 'sourceObject', 'targetObject',
  'sourceVariable', 'targetVariable', and 'forwardType'.
  The \code{\link{hydroModelData}} method returns a
  suitable input (see its \code{fileObjLink} argument).}

  \item{gageObjects}{A vector holding the names (IDs) of
  the objects of interest.  This should be valid names in R
  (letters, digits, underscore).  In hydrological
  applications, these are objects containing (or
  representing) stream gages. The supplied objects must
  exist in the 'object' column of \code{tab_objDecl} and in
  the 'targetObject' column of \code{tab_objLink}.}
}
\value{
  A data identical to \code{tab_objDecl} but with as many
  additional columns as there are elements in the vector
  \code{gageObjects}. These additional columns are of type
  integer. A value of 1 indicates, that the object of
  interest (specified in the column name) is affected by
  the object given in the 'object' column of the respective
  row. In models with only feed-forward interactions, this
  means that the object in the 'object' column is located
  upstream of the object of interest (given as column
  name).  In models with feedbacks, this is not necessarily
  so.  A value of 0 indicates that the object of interest
  (column name) is not affected by the object given in the
  'object' column.
}
\description{
  This function solves the problem of finding all objects
  in a network that affect a particular object of interest
  which is part of the network.
}
\note{
  The function is applicable to dendritic (i.e. tree-like)
  systems as well as to meshed systems (i.e. systems with
  flow diversions).

  The function is also capable of handling both types of
  object links, i.e.  forward (upstream to downstream) as
  well as backward interactions (feedbacks).

  The current implementation may be slow if applied to very
  large systems.
}
\examples{
# Generation of sample object declaration table (with spatial coordinates)
decl= data.frame(stringsAsFactors=FALSE,
  object=c("a","b","c","d","e","f","g","h","i","a2","b2","p","q","r","s","t","p2"),
  objectGroup="-",
  xpos= c(  1,  1,  2,  2,  1,  1,  2,  2,  1,   3,   3,  6,  5,  4,  3,  3,   6),
  ypos= c(  9,  8,  7,  6,  5,  4,  3,  2,  1,   9,   8,  8,  7,  6,  5,  4,   6)
)
# Generation of corresponding object linkage table
link= data.frame(stringsAsFactors=FALSE,
  sourceObject=c("a","b","c","d","d","e","f","g","h","a2","b2","p","q","r","s","t","p2","t"),
  targetObject=c("b","c","d","e","s","f","g","h","i","b2","c", "q","r","s","t","g","q","d"),
  sourceVariable="-", targetVariable="-",
  forwardType=as.logical(c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0))
)
# Definition of gage objects
gages= c("s", "h", "e", "r", "b")

# Call method
result=assignGages(tab_objDecl=decl[,1:2], tab_objLink=link, gageObjects=gages)
# Plot basic network
plot(range(decl$xpos)+c(-1,1), range(decl$ypos)+c(-1,1),
  type="n", xlab="x", ylab="y")
for (i in 1:nrow(link)) {
  i_src= match(link$sourceObject[i], decl$object)
  i_tar= match(link$targetObject[i], decl$object)
  lines(x=decl$xpos[c(i_src,i_tar)], y=decl$ypos[c(i_src,i_tar)], col="grey",
    lty=2-link$forwardType[i])
}
points(decl$xpos, decl$ypos, col="grey", cex=3)
text(decl$xpos, decl$ypos, decl$object)
# Show gages and their upstream objects
clr= rainbow(length(gages))
for (i in 1:length(gages)) {
  points(x=decl$xpos[decl$object==gages[i]], y=decl$ypos[decl$object==gages[i]],
    col=clr[i], pch=20, cex=3)
  text(x=decl$xpos[decl$object==gages[i]], y=decl$ypos[decl$object==gages[i]],
    gages[i])
  gagedObj= result$object[which(result[,gages[i]] != 0)]
  if (length(gagedObj) > 0) {
    sub= subset(decl, decl$object \%in\% gagedObj)
    points(sub$xpos, sub$ypos, cex=3+i, col=clr[i])
  }
}
legend("bottomright", bty="n", pch=c(20,1), legend=c("Gage object","Influencing obj."))
legend("topright", bty="n", lty=c(1,2), legend=c("Forward link","Backward link"))
}
\author{
  David Kneis \email{david.kneis@uni-potsdam.de}
}

