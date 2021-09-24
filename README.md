
# Age-based Maintenance under Population Heterogeneity: Optimal Exploration and Exploitation

Data and codes for the paper Age-Based Maintenance under Population Heterogeneity: Optimal Exploration and Exploitation, Dursun, Ipek and Akçay, Alp and van Houtum, Geert-Jan,  (2021). 
The preprint version of this paper is available at SSRN: https://ssrn.com/abstract=3871676 or http://dx.doi.org/10.2139/ssrn.3871676 

## Introduction
Inside of this repository you can find:
- *The data generated for the experimnents in the paper.*
- *The code to generate optimal age-based policies under given parameter.*
- *A user interface developed as an R shiny app where data can be accessed by the end-user.*
- *A manual for the user interface.*

## Content of Repository

The codes should be run in the following order:

**'setup.R'**: This file contains the packages that must be installed before running the other R codes. 

**'Part0-Functions.R'**: Functions that are needed to upload to R before running Part 1 and Part 2. 

**'Part1-Generating-dataset.R'**: This code generates state space, time-to-failure distribution dependent values and cost dependent values. In this part of code, there are three subparts. Part A is to create state space. Parameters are total lifespan of the system ('L') and discretization level for belief variable ('p_increment'). Users are not advised to change this parameters.
Part B is for generating state transition data based on a given distribution. We assume a discretized version of Weibull distribution for this purpose. 'alpha' denotes the shape parameter of the distribution for both weak and strong populations. 'beta_1' denotes the scale parameter for weak population and 'beta_2' denotes the scale parameter for strong population. Part C is to generate immediate costs based on the parameters for the cost of the corrective maintenance ('C_f') and the cost of the preventive maintenance ('C_p'). 



**'Part2-Applying-Optimal-Policy.R'**: This code generates the optimal policy for the given state space and data from Part 1. 

**'tool-int.Rdata'**: Data generated by optimal policy based on the experiment settings in Dursun, Akcay and van Houtum, 2021. This data will be used in R shiny app created as user interface. 

**'app.R'**: Shiny application to access the model output by the end user. 

## Dependencies

**R** (Software for Statistical Computing): These codes are supported by R version 4.0.5. 

The following R packages are used in the development of the optimal age-based maintenance algorithm:
 `dplyr`, `plyr`, `data.table`. 

The following R packages are used in the user interface: 
`shiny`, `shinydashboard`,  `dplyr`, `plyr`, `ggplot2`, `callr`, `shinyBS`, `shinyWidgets`, `DT`, `data.table`. 

You can contact to Ipek (i.dursun@tue.nl) for your questions of you encounter any issues.

## References to software dependencies:

[1] R Core Team (2019). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL: https://www.R-project.org/.

[2] Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2018). shiny: Web Application Framework for R. R package version 1.2.0.
  https://CRAN.R-project.org/package=shiny

[3] Winston Chang and Barbara Borges Ribeiro (2018). shinydashboard: Create Dashboards with 'Shiny'. R package version 0.7.1.  https://CRAN.R-project.org/package=shinydashboard

[4] Hadley Wickham, Romain François, Lionel Henry and Kirill Müller (2019). dplyr: A Grammar of Data Manipulation. R package version 0.8.0.1.
  https://CRAN.R-project.org/package=dplyr

[5] Hadley Wickham (2011). The Split-Apply-Combine Strategy for Data Analysis. Journal of Statistical Software, 40(1), 1-29. URL http://www.jstatsoft.org/v40/i01/.

[6] H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York, 2016.

[7] Gábor Csárdi and Winston Chang (2019). callr: Call R from R. R package version 3.2.0. https://CRAN.R-project.org/package=callr

[8] Eric Bailey (2015). shinyBS: Twitter Bootstrap Components for Shiny. R package version 0.61. https://CRAN.R-project.org/package=shinyBS

[9] Victor Perrier, Fanny Meyer and David Granjon (2019). shinyWidgets: Custom Inputs Widgets for Shiny. R package version 0.4.8.
  https://CRAN.R-project.org/package=shinyWidgets

[10] Yihui Xie, Joe Cheng and Xianying Tan (2018). DT: A Wrapper of the JavaScript Library 'DataTables'. R package version 0.5. https://CRAN.R-project.org/package=DT

[11] Matt Dowle and Arun Srinivasan (2019). data.table: Extension of `data.frame`. R package version 1.12.0. https://CRAN.R-project.org/package=data.table


