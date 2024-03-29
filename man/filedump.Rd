% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filedump.R
\docType{class}
\name{filedump}
\alias{filedump}
\title{The file dumping logger.}
\format{
An \code{R6} class object.
}
\description{
The file dumping logger dumps the most recent version of a dataset to csv in
a directory of choice.
}
\section{Creating a logger}{


\code{filedump$new(dir=file.path(tempdir(),"filedump"), filename="\%sstep\%03d.csv",verbose=TRUE)}
\tabular{ll}{
  \code{dir}\tab \code{[character]} Directory location to write the file dumps.\cr
  \code{filename}\tab \code{[character]} Template, used to create file names.
                      to create a file name.\cr
  \code{verbose}\tab \code{[logical]} toggle verbosity.
}

File locations are created with \code{file.path(dir, file)}, where
\code{file} is generated as \code{sprintf(filename, DATA, STEP)}. In
interactive sessions \code{DATA=""}. In sessions where a script is executed
using \code{\link{run_file}}, \code{DATA} is the name of the R object being
tracked or the \code{label} provided with \code{\link{start_log}}.
\code{STEP} is a counter that increases at each dump.
}

\section{Dump options}{
 

\code{$dump(...)}
\tabular{ll}{
  \code{...}\tab Currently unused.\cr
}
}

\section{Retrieve log data}{


\code{$logdata()} returns a list of data frames, sorted in the order returned by
 \code{base::dir()}
}

\section{Details}{


If \code{dir} does not exist it is created.
}

\examples{
logger <- filedump$new()

out <- women \%L>\%
  start_log(logger) \%L>\%
  within(height <- height * 2) \%L>\%
  within(height <- height * 3) \%L>\%
  dump_log()
dir(file.path(tempdir(),"filedump"))


}
\seealso{
Other loggers: 
\code{\link{cellwise}},
\code{\link{expression_logger}},
\code{\link{no_log}},
\code{\link{simple}}
}
\concept{loggers}
