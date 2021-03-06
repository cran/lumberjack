% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lumberjack.R
\name{stop_log}
\alias{stop_log}
\title{Stop logging}
\usage{
stop_log(data, logger = NULL, dump = TRUE, ...)
}
\arguments{
\item{data}{An R object.}

\item{logger}{\code{[character]} vector. Class names of loggers to dump (e.g.
\code{"simple"}).  When \code{loggers=NULL}, all loggers are stopped and
removed for this data.}

\item{dump}{\code{['logical']} Toggle dump log file.}

\item{...}{Passed to the logger's \code{dump} method, if it exists.}
}
\value{
The data, invisibly.
}
\description{
Calls the logger's \code{$stop()} method if it exists, and removes
the logger as attribute from \code{data}.
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
\code{\link{start_log}()}
}
\concept{control}
