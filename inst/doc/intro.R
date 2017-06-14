## ---- echo=FALSE---------------------------------------------------------
library(lumberjack)

## ----eval=FALSE----------------------------------------------------------
#  install.packages("lumberjack")

## ------------------------------------------------------------------------
out <- women %>>%
  start_log() %>>%
  identity() %>>%
  head() %>>%
  dump_log(stop=TRUE)
read.csv("simple_log.csv")

## ------------------------------------------------------------------------
logfile <- tempfile(fileext = ".csv")
women$a_key <- seq_len(nrow(women))
out <- women %>>%
  start_log( log = cellwise$new(key="a_key") ) %>>%
  {.$height[1] <- 60; .} %>>%
  head(13) %>>%
  dump_log(file=logfile, stop=TRUE)

read.csv(logfile)

## ------------------------------------------------------------------------
dat <- start_log(women, log = simple$new())

## ------------------------------------------------------------------------
dat <- start_log(women, log=simple$new(verbose=FALSE))

## ------------------------------------------------------------------------
out <- dat %>>% identity() %>>% dump_log()
read.csv("simple_log.csv")

## ------------------------------------------------------------------------
out <- dat %>>% 
  start_log() %>>% 
  identity() %>>% 
  dump_log(file="log_all_day.csv")
read.csv("log_all_day.csv")

## ------------------------------------------------------------------------
out <- 1:3 %>>% 
  start_log() %>>%
  {.*2} %>>%
  dump_log(file="foo.csv", stop=TRUE)

print(out)

read.csv("foo.csv")

