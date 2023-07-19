#' getUsername
#'
#' @return Username
#' @export
#'
#' @examples getUsername()
getUsername<- function(){

  user <- Sys.getenv(c("USER", "USERNAME"))
  user <- user[user != ""]
  if (length(user) == 0) {
    # Sys.info() is not implemented on all machines, if not it returns NULL,
    # which the below code will handle properly.
    user <- Sys.info()["user"]
    user <- user[user != "" & user != "unknown"]
    if (length(user) == 0) {
      con <- pipe("/usr/bin/env whoami")
      user <- readLines(con)
      close(con)
    }
  }
  user[1]
}


