#' create_sascfg_personal_py
#'
#' @param local TRUE or FALSE either local windows machine or workbench remote
#' @param iomhost proc iomoperate - url of Operating System Services
#' @param class_id proc iomoperate - SAS Workspace Server Class identifier information 
#'
#' @description generate the config files to connect SAS
#' @return "sascfg_personal.py created" 
#' @export
#'
#' @examples
#' \dontrun{
#' create_sascfg_personal_py(local = TRUE, iomhost = 'aws-saspv1.mycompany.com', class_id = 'letter-number')
#' }   
create_sascfg_personal_py <- function(local = TRUE, iomhost = 'aws-saspv1.mycompany.com', class_id = 'letter-number'){
 
  if ( isTRUE( local ) ) {

    path = paste0("C:\\Users\\", getUsername())
 
    if ( !dir.exists( file.path( path, ".config") ) ){
      dir.create( file.path( path, ".config") )
    }

    if ( !dir.exists( file.path( path, ".config", "saspy") ) ){
      dir.create( file.path( path, ".config", "saspy") )
    } 

    writeLines(
      paste0 ( "SAS_config_names=['iomcom']
iomcom = {'java' : 'C:\\\\Program Files (x86)\\\\Common Files\\\\Oracle\\\\Java\\\\javapath\\\\java.exe',
'iomhost': '",iomhost,"',
'iomport': 8591,
'authkey' : 'IOM_Prod_Grid1',
'class_id': '",class_id,"'
}"),
      file.path( path, ".config", "saspy", "sascfg_personal.py")
    )
 
  } else {

    path = paste0("/home/", getUsername())
 
    if ( !dir.exists( file.path( path, ".config") ) ){
      dir.create( file.path( path, ".config") )
    }

    if ( !dir.exists( file.path( path, ".config", "saspy") ) ){
      dir.create( file.path( path, ".config", "saspy") )
    }
 
    writeLines(
      paste0 ( "SAS_config_names=['iomcom']
iomcom = {'java' : '/usr/bin/java',
'iomhost': '",iomhost,"',
'iomport': 8591,
'authkey' : 'IOM_Prod_Grid1',
'class_id': '",class_id,"'
}"),
      file.path( path, ".config", "saspy", "sascfg_personal.py")
    )

  }
    
  return("sascfg_personal.py created")

}

