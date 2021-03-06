\name{update_template}
\alias{update_template}
\title{Update a template file containing placeholders}
\usage{
update_template(file_template, vect_updates, char_open = "{",
  char_close = "}", file_result, overwrite = FALSE)
}
\arguments{
  \item{file_template}{Name of the file containing the
  placeholders to be updated.}

  \item{vect_updates}{A \emph{named} vector containing the
  values by which the placeholders in \code{file_template}
  are to be substituted. Typically, this is a numeric
  vector or a vector of character strings.}

  \item{char_open}{Single character to identify the start
  of a placeholder in \code{file_template}.}

  \item{char_close}{Single character to identify the end of
  a placeholder in \code{file_template}.}

  \item{file_result}{Name of the output file. The contents
  is the same as in \code{file_template} but placeholders
  are substituted by the matching values in
  \code{vect_update}. See details.}

  \item{overwrite}{If \code{FALSE} (default), existing
  results files will not be overwritten.}
}
\value{
The function returns an integer value being the number of
placeholders which have been substituted in
\code{file_template}.
}
\description{
The function substitutes placeholders in a template file by
actual value(s) provided in a named vector. It can be used
in the automatic calibration of models which read numerical
parameters from text files.
}
\note{
For successful updating of the template file, the string
between the opening and closing character of a placeholder
must match with the name of an element in
\code{vect_updates}. For example, given that
\code{char_open='<'} and \code{char_open='>'}, a
placeholder \emph{<p1>} in the template file will be
substituted by the element of \code{vect_updates} whose
name is 'p1'.

The substitution values are printed using R's default
formatting rules. If a specific number format is required,
\code{vect_updates} should be a vector of character strings
holding the properly formatted numbers rather than a
numeric vector.
}
\examples{
# Create simple template file with placeholders for two values
fin= tempfile()
write(file=fin, x='p1 {p1} p2 {p2}')
# Update the template
fout= tempfile()
n= update_template(file_template= fin, vect_updates=c(p1=5.0, p2=3.0),
  file_result=fout)
print(paste("Updated locations:",n))
# Show result and clean up
x= readLines(con=fout)
print(x)
file.remove(fin)
file.remove(fout)
}
\author{
David Kneis \email{david.kneis@uni-potsdam.de}
}

