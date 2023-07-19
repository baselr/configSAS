#' create_pass
#'
#' @param local TRUE or FALSE either local windows machine or workbench remote 
#'
#' @description generate the authinfo file to connect SAS
#' @return "pass created"
#' @import askpass
#' @export
#'
#' @examples
#' \dontrun{
#' create_pass(local = TRUE)
#' } 
create_pass <- function(local = TRUE){
  
  if ( isTRUE( local ) ) {
    
    path = paste0("C:\\Users\\", getUsername())
    
    writeLines(
      paste ("IOM_Prod_Grid1 user", getUsername(),"password", askpass::askpass("Please enter your password") ) ,
      file.path( path, "_authinfo")
    )
    
    
  } else {
    
    path = paste0("/home/", getUsername())
    
    writeLines(
      paste ("IOM_Prod_Grid1 user", getUsername(),"password", askpass::askpass("Please enter your password") ) ,
      file.path( path, ".authinfo")
    )

  } 
  
  return("pass created")
  
}


