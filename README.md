
## Age-based Maintenance under Population Heterogeneity: Optimal Exploration and Exploitation

Codes for the paper Age-Based Maintenance under Population Heterogeneity: Optimal Exploration and Exploitation, Dursun, İpek and Akçay, Alp and van Houtum, Geert-Jan,  (Available online 25 November 2021), In-Press, European Journal of Operational Research

## Introduction
Inside of this repository you can find:

- *The code to generate optimal age-based policies under given parameter.*

## Content of Repository

The codes should be run in the following order:

**'Part0-Functions.R'**: Functions that are needed to upload to R before running Part 1 and Part 2. 

**'Part1-Generating-dataset.R'**: This code generates state space, time-to-failure distribution dependent values and cost dependent values. In this part of code, there are three subparts. Part A is to create state space. Parameters are total lifespan of the system ('L') and discretization level for belief variable ('p_increment'). Users are not advised to change this parameters.
Part B is for generating state transition data based on a given distribution. We assume a discretized version of Weibull distribution for this purpose. 'alpha' denotes the shape parameter of the distribution for both weak and strong populations. 'beta_1' denotes the scale parameter for weak population and 'beta_2' denotes the scale parameter for strong population. Part C is to generate immediate costs based on the parameters for the cost of the corrective maintenance ('C_f') and the cost of the preventive maintenance ('C_p'). 

**'Part2-Applying-Optimal-Policy.R'**: This code generates the optimal policy for the given state space and data from Part 1. 


## Dependencies

**R** (Software for Statistical Computing): These codes are supported by R version 4.0.5. 

The following R packages are used in the development of the optimal age-based maintenance algorithm:
 `dplyr`, `plyr`, `data.table`. 

You can cite our work as:

İpek Dursun, Alp Akçay, Geert-Jan van Houtum, Age-based maintenance under population heterogeneity: Optimal exploration and exploitation,
European Journal of Operational Research, 2021, ISSN 0377-2217, https://doi.org/10.1016/j.ejor.2021.11.038.

## References to software dependencies:

[1] R Core Team (2019). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL: https://www.R-project.org/.

[4] Hadley Wickham, Romain François, Lionel Henry and Kirill Müller (2019). dplyr: A Grammar of Data Manipulation. R package version 0.8.0.1.
  https://CRAN.R-project.org/package=dplyr

[5] Hadley Wickham (2011). The Split-Apply-Combine Strategy for Data Analysis. Journal of Statistical Software, 40(1), 1-29. URL http://www.jstatsoft.org/v40/i01/.

[6] H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York, 2016.

[10] Yihui Xie, Joe Cheng and Xianying Tan (2018). DT: A Wrapper of the JavaScript Library 'DataTables'. R package version 0.5. https://CRAN.R-project.org/package=DT

[11] Matt Dowle and Arun Srinivasan (2019). data.table: Extension of `data.frame`. R package version 1.12.0. https://CRAN.R-project.org/package=data.table


