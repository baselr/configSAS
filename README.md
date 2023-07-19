# configSAS

Generate The Config Files To Connect to SAS

`install.packages("devtools")`

`devtools::install_github("baselr/configSAS")`

### Also tidyverse and reticulate are required:

`install.packages("tidyverse")`

`install.packages("reticulate")`

## How to know about your SAS environment?

`%let metaserver_host = "sas.mycompany.com";`

`proc iomoperate;`

`connect host = &metaserver_host`

`port = 8561`

`iomopts = 'securitypackage=Negotiate,securitypackagelist=Kerberos';`

`list commands;`

`list DEFINED FILTER="Object";`

`list types;`

`quit;`

# Get started

#== Installation setup ==#

\# install python modules needed to connect SAS

`install_python_module()`

\# create the config files to connect SAS

`create_sascfg_personal_py(local = TRUE, iomhost = 'aws-saspv1.mycompany.com', class_id = 'letter-number')`

#== working with SAS on quarto ==#

\# create the authinfo file

`create_pass(local = TRUE)`

\# generate a quarto document example

`test_SAS()`

\# delete the authinfo file

`delete_pass(local = TRUE)`
