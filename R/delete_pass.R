#' delete_pass 
#'
#' @param local TRUE or FALSE either local windows machine or workbench remote 
#'
#' @description delete the authinfo file to connect SAS
#' @return "pass deleted" 
#' @export
#'
#' @examples
#' \dontrun{
#' delete_pass(local = TRUE)
#' }   
delete_pass <- function(local = TRUE){
  
  if ( isTRUE( local ) ) {
    
    path = paste0("C:\\Users\\", getUsername())
    
    if (file.exists(file.path( path, "_authinfo"))) {
      #Delete file if it exists
      file.remove(file.path( path, "_authinfo"))
    }
      
  } else {
    
    path = paste0("/home/", getUsername())
    
    if (file.exists(file.path( path, ".authinfo"))) {
      #Delete file if it exists
      file.remove(file.path( path, ".authinfo"))
    } 
    
  } 
  
  return("pass deleted")
  
}


