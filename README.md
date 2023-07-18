---
editor_options: 
  markdown: 
    wrap: 72
---

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
