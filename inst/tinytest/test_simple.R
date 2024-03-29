library(lumberjack)
## simple logger

logfile <- tempfile()
i2 <- start_log(iris, simple$new(verbose=FALSE)) 
i2 <- i2 %>>%  identity()    
i2 <- i2 %>>% head()     
i2 <- dump_log(i2, file=logfile, stop=TRUE) 
expect_equal(nrow(read.csv(logfile)),2)
  
# crash test: does multi-piping work under NSE?
i2 <- head(women) %>>% 
        start_log(simple$new(verbose=FALSE)) %>>% 
        identity() %>>% 
        dump_log(file=logfile)
expect_true(file.exists(logfile))

#If we dump to the same file we expect an overwrite.
logger <- simple$new()
iris %>>% start_log(logger) %>>% head() %>>% stop_log(dump=FALSE)
expect_equal(nrow(logger$logdata()), 1L)
expect_equal(nrow(read.csv(logfile)), 1L) 

expect_true("label" %in% ls(simple$new()))

