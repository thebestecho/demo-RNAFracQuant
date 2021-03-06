% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_files.R
\name{read_count_files}
\alias{read_count_files}
\title{Read count files}
\usage{
read_count_files(dir_in, file)
}
\arguments{
\item{dir_in}{The input directory name}

\item{file}{The input Samplesheet file name}
}
\description{
Read all the count file that are provided by users.
}
\details{
This function is to read the samplesheet file that is provided by users
and then use it to read all the count files. Useres need to make sure that the 
samplesheet file and all the count files are within the same input directory.
}
\examples{
\dontrun{
read_count_files("inst/extdata","Samplesheet")
read_count_files(dir_in = "inst/extdata",file = "Samplesheet")
}
}
\keyword{counts}
