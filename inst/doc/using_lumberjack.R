### R code from vignette source 'using_lumberjack.Rnw'

###################################################
### code chunk number 1: using_lumberjack.Rnw:75-79
###################################################
options(prompt="  ",
        continue = "  ",
        width=100)
library(lumberjack)


###################################################
### code chunk number 2: using_lumberjack.Rnw:135-137
###################################################
library(lumberjack)
out <- run_file("process.R")


###################################################
### code chunk number 3: using_lumberjack.Rnw:140-141
###################################################
head(out$women, 3)


###################################################
### code chunk number 4: using_lumberjack.Rnw:146-147
###################################################
read.csv("women_simple.csv")


###################################################
### code chunk number 5: using_lumberjack.Rnw:207-210 (eval = FALSE)
###################################################
## start_log(mtcars, logger=simple$new())
## # all data transformations here...
## dump_log(file="hihi.csv")


###################################################
### code chunk number 6: using_lumberjack.Rnw:230-234 (eval = FALSE)
###################################################
## start_log(women, logger=simple$new())
## start_log(mtcars, logger=simple$new())
## # all data transformations here...
## dump_log()


###################################################
### code chunk number 7: using_lumberjack.Rnw:240-241 (eval = FALSE)
###################################################
## dump_log(data=mtcars)


###################################################
### code chunk number 8: using_lumberjack.Rnw:247-252 (eval = FALSE)
###################################################
## women$id <- 1:15
## start_log(women, logger=simple$new())
## start_log(women, logger=cellwise(key="id"))
## # all data transformations here...
## dump_log()


###################################################
### code chunk number 9: using_lumberjack.Rnw:258-259 (eval = FALSE)
###################################################
## dump_log(women, "cellwise")


###################################################
### code chunk number 10: using_lumberjack.Rnw:273-282
###################################################
data(women)
women$id <- 1:15
out <- women %L>%
  start_log(logger = cellwise$new(key="id")) %L>%
  transform(height = height*0.0254  ) %L>%
  transform(weight = weight*0.453592) %L>%
  transform(bmi    = weight/height^2) %L>%
  dump_log()
head( read.csv("cellwise.csv"), 3)


###################################################
### code chunk number 11: using_lumberjack.Rnw:289-290
###################################################
head(out,3)


###################################################
### code chunk number 12: using_lumberjack.Rnw:318-325
###################################################
logger <- expression_logger$new(mean_h = mean(height), sd_h = sd(height))
out <- women %L>%
  start_log(logger) %L>%
  transform(height = height*2.54) %L>% 
  transform(weight = weight*0.453592) %L>%
  dump_log()
read.csv("expression.csv",stringsAsFactors = FALSE)


###################################################
### code chunk number 13: using_lumberjack.Rnw:350-361
###################################################
# pass the first argument to a function
1:3 %L>% mean()

# pass arguments using "."
TRUE %L>% mean(c(1,NA,3), na.rm = .)

# pass arguments to an expression, using "."
1:3 %L>% { 3 * .}

# in a more complicated expression, return "." explicitly
women %L>% { .$height <- 2*.$height; . } %L>% head(3)


###################################################
### code chunk number 14: using_lumberjack.Rnw:417-434
###################################################
library(R6)
trivial <- R6Class("trivial",
  public = list(
    changed = NULL
  , label=NULL
  , initialize = function(){
      self$changed <- FALSE
  }
  , add = function(meta, input, output){
    self$changed <- self$changed | !identical(input, output)
  }
  , dump = function(){
    msg <- if(self$changed) "" else "not "
    cat(sprintf("The data has %schanged\n",msg))
  }
  )
)


###################################################
### code chunk number 15: using_lumberjack.Rnw:437-448
###################################################
library(lumberjack)
out <- women %L>% 
  start_log(trivial$new()) %L>%
  identity() %L>%
  dump_log(stop=TRUE)


out <- women %L>%
  start_log(trivial$new()) %L>%
  head() %L>%
  dump_log(stop=TRUE)


###################################################
### code chunk number 16: using_lumberjack.Rnw:455-474
###################################################
library(methods)
trivial <- setRefClass("trivial",
  fields = list(
    changed = "logical", label="character"
  ),
  methods = list(
    initialize = function(){
      .self$changed = FALSE
      .self$label = ""
    }
    , add = function(meta, input, output){
      .self$changed <- .self$changed | !identical(input,output)
    }
    , dump = function(){
      msg <- if( .self$changed ) "" else "not "
      cat(sprintf("The data has %schanged\n",msg))
    }
  )
)


###################################################
### code chunk number 17: using_lumberjack.Rnw:477-489
###################################################
library(lumberjack)
out <- women %L>% 
  start_log(trivial()) %L>%
  identity() %L>%
  dump_log(stop=TRUE)


out <- women %L>%
  start_log(trivial()) %L>%
  head() %L>%
  dump_log(stop=TRUE)



