#' test_SAS
#' @description generate a quarto with SAS
#' @return browse to results
#' @import utils
#' @export
#'
#' @examples
#' \dontrun{
#' test_SAS()
#' }
test_SAS <- function(){
writeLines(
'---
title: "Quarto Demo with SAS"
format: html
toc: true
self-contained: true
---

## Setup

saspy is required to run SAS commands from python/jupyter.

```{r}
library(configSAS)
configSAS::set_sas_engine()
sas = knitr::opts_chunk$get("sas")
```

## Do some SAS
```{sas}
data WORK.EGGS_WHY;
  do i = 1 to 100;
     eggs = rand("norm");
     why  = eggs**2 + rand("unif")*3;
     output;
  end;
run;

proc sql;
   select type, count(*) as numberofmodels, avg(MPG_city) as Avg_MPG_City
   from sashelp.cars
   group by type
   order by 3 desc;
quit;
```


## A graph from SAS

```{sas}
#| echo: true
#| capture: lst

data xyz;
  call streaminit(280870);

  do x=1 to 100;
     y=(x/10) ** 2;
     z=x * (1+rand("unif")/3);
     output;
  end;
run;


ods graphics on;
proc corr
  data  = xyz
  plots = matrix(histogram);
run;

```

### here only capturing the log not lst
```{sas}
#| echo: true
#| capture: log

data xyz;
  call streaminit(280870);

  do x=1 to 100;
     y=(x/10) ** 2;
     z=x * (1+rand("unif")/3);
     output;
  end;
run;

```

### a scatter plot from a previous data generated available in work

```{sas}
#| echo: true
#| capture: lst
libname work list;

ods graphics on;

proc sgplot data=eggs_why;
  title "Scatter plot";
  scatter y=why x=eggs;
run;

```


## SAS data to R
```{r}

eggs_in_r <- sas$get("EGGS_WHY", "WORK")

head(eggs_in_r)

```

## just get a data to send to python or SAS
```{r}
mydata_r = iris
```

# R data to SAS
```{r}
sas$to( df = mydata_r , table = "yo", libref = "work" )
```

## see in SAS that we have a new table from R
```{sas}
#| capture: log

proc sql;
   select  count(*) as number_of_eggs
   from work.yo;
quit;
```


# Setup Python

```{python}
import pandas as pd
```

## R to Python
```{python}
#| echo: true
data_pd = r.mydata_r
data_pd.describe()
```

## Python to R

```{r}
#| echo: true
mydata_r <- reticulate::py$data_pd

# get a summary based on python environment object
summary(mydata_r)
```

',
    "test_SAS.qmd"
  )

  system("quarto render test_SAS.qmd", intern = TRUE)

 try( utils::browseURL("test_SAS.html") )
}
