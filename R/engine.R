#' SAS
#' @export
#' @import R6
#' @importFrom reticulate import
SAS <- R6::R6Class(
  public = list(
    initialize = function() {
      private$.exe <- reticulate::import("saspy", delay_load = TRUE, convert = FALSE)
      private$.session <- private$.exe$SASsession()
    },
    #' @param code code chunk
    submit = function(code) {
      private$.session$submit(code)
    },
    #' @param code code chunk
    submitLST = function(code) {
      private$.session$submitLST(code)
    },
    #' @param table name of table in SAS
    #' @param lib name of SAS libname
    get = function(table, lib) {
      reticulate::py_to_r( private$.session$sasdata(table, lib)$to_df() )
    },
    #' @param df dataframe R
    #' @param table name of table in SAS
    #' @param libref name of SAS libname
    to = function( df , table, libref ){
      private$.session$dataframe2sasdata( df, table, libref )
    }
  ),
  active = list(
    session = function(value) {
      if(!missing(value))
        stop("This field is read-only")

      private$.session
    },
    process = function(value) {
      if(!missing(value))
        stop("This field is read-only")

      private$.exe
    }
  ),
  private = list(
    .exe = NULL,
    .session = NULL
  )
)

#' Knitr engine for SAS
#'
#' @import evaluate htmltools knitr
#' @export
set_sas_engine <- function(){
  knitr::opts_chunk$set(
    sas = configSAS::SAS$new()
  )
  knitr::knit_engines$set(sas = function(
    options
  ) {
    out <- ""
    code <- paste0(options$code, collapse = "\n")

    if (options$eval)
      out <- options$sas$submit(code)

    res <- htmltools::HTML(paste( out$LST , collapse = "\n"))
    log <- htmltools::HTML(paste( out$LOG , collapse = "\n"))

    Sys.setenv("lastSAScall" = res )
    Sys.setenv("lastSAScall_log" = log )

    if ( isTRUE( !is.null(options$results) & options$results == "hide" ) ) {

      return(knitr::engine_output(options, options$code, out))

    }

    options$results <- "hide"

    if ( isTRUE( is.null(options$capture) ) |  isTRUE( options$capture == "both") ) {

      out <- c(paste(
        '::: panel-tabset',
        '## lst',
        evaluate::evaluate('htmltools::HTML(paste( out$LST , collapse = "\n"))' ),
        '## log',
        evaluate::evaluate(' htmltools::pre(paste( out$LOG , collapse = "\n"))' ),
        ':::
        ',
        sep="\n"))

      options$results <- "asis"

    } else if(options$capture == "lst") {

      out <- c(paste(
        '::: panel-tabset',
        '## lst',
        evaluate::evaluate('htmltools::HTML(paste( out$LST , collapse = "\n"))' ),
        ':::
        ',
        sep="\n"))

      options$results <- "asis"

    } else if(options$capture == "log") {

      out <- c(paste(
        '::: panel-tabset',
        '## log',
        evaluate::evaluate(' htmltools::pre(paste( out$LOG , collapse = "\n"))' ),
        ':::
        ',
        sep="\n"))

      options$results <- "asis"

    }

    knitr::engine_output(options, options$code, out[2])
  })
}
