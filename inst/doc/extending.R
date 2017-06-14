## ------------------------------------------------------------------------
library(R6)
trivial <- R6Class("trivial",
  public = list(
    changed = NULL
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

## ------------------------------------------------------------------------
library(lumberjack)
out <- women %>>% 
  start_log(trivial$new()) %>>%
  identity() %>>%
  dump_log(stop=TRUE)


out <- women %>>%
  start_log(trivial$new()) %>>%
  head() %>>%
  dump_log(stop=TRUE)

## ------------------------------------------------------------------------
library(methods)
trivial <- setRefClass("trivial",
  fields = list(
    changed = "logical"
  ),
  methods = list(
    initialize = function(){
      .self$changed = FALSE
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

## ------------------------------------------------------------------------
library(lumberjack)
out <- women %>>% 
  start_log(trivial()) %>>%
  identity() %>>%
  dump_log(stop=TRUE)


out <- women %>>%
  start_log(trivial()) %>>%
  head() %>>%
  dump_log(stop=TRUE)


