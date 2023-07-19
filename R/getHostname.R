#' getHostname
#'
#' @return Hostname
#' @export
#'
#' @examples getHostname()
getHostname <- function(){
  host <- Sys.getenv(c("HOST", "HOSTNAME", "COMPUTERNAME"))
  host <- host[host != ""]
  if (length(host) == 0) {
    # Sys.info() is not implemented on all machines, if not it returns NULL,
    # which the below code will handle properly.
    host <- Sys.info()["nodename"]
    host <- host[host != ""]
    if (length(host) == 0) {
      con <- pipe("/usr/bin/env uname -n")
      host <- readLines(con)
      close(con)
    }
  }
  host[1]
}



