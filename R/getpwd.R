#' getpwd
#'
#' @return pwd
#' @export
#'
#' @examples getpwd()
getpwd <- function(){
  con <- pipe("pwd")
  pwd <- readLines(con)
  close(con)
  return( pwd )
}
