% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lumberjack.R
\name{start_log}
\alias{start_log}
\title{Start tracking an R object}
\usage{
start_log(data, logger = simple$new(), label = NULL)
}
\arguments{
\item{data}{An R object.}

\item{logger}{A logging object (typically an environment wrapped in an S3 class)}

\item{label}{\code{[character]} scalar. A label to attach to the logger (for
loggers supporting it).}
}
\description{
Start tracking an R object
}
\section{Details}{

All loggers that come with \pkg{lumberjack} support labeling. The label is
used by \code{dump} methods to create a unique file name for each
object/logger combination.

If \code{label} is not supplied, \code{start_log} attempts to create a label
from the name of the \code{data} variable. This probably fails when
\code{data} is not a variable but an expression (like \code{read.csv...}). A
label is also not created when data is passed via the lumberjack not-a-pipe
operator.  In that case the label is (silently) not set. In cases where
multiple datasets are logged with the same type of logger, this could lead
to overwriting of dump files, unless \code{file} is explicitly defined when
calling \code{\link{dump_log}}.
}

\examples{
logfile <- tempfile(fileext=".csv")
women \%L>\%
  start_log(logger=simple$new()) \%L>\%
  transform(height_cm = height*2.52) \%L>\%
  dump_log(file=logfile)
logdata <- read.csv(logfile)
head(logdata)

}
\seealso{
Other control: 
\code{\link{\%>>\%}()},
\code{\link{dump_log}()},
\code{\link{get_log}()},
\code{\link{run_file}()},
\code{\link{stop_log}()}
}
\concept{control}
