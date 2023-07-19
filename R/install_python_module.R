#' install_python_module
#'
#' @param moption TRUE or FALSE sometime it is required to specify python3 -m to install a module
#'
#' @description install python modules to connect SAS
#' @return "Modules installed" 
#' @export
#'
#' @examples
#' \dontrun{
#' install_python_module()
#' }    
install_python_module <- function(moption = FALSE){
  
  if ( isTRUE( moption ) ) {
    system("pip install --user pandas", intern = TRUE)
    system("pip install --user saspy", intern = TRUE)
  } else {
    system("python3 -m pip install --user pandas", intern = TRUE)
    system("python3 -m pip install --user saspy", intern = TRUE)
  }
  
return("Modules installed") 
  
}
