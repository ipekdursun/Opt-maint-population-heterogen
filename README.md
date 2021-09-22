
# Age-based Maintenance under Population Heterogeneity: Optimal Exploration and Exploitation

Data and codes for the paper Age-Based Maintenance under Population Heterogeneity: Optimal Exploration and Exploitation, Dursun, Ipek and Akçay, Alp and van Houtum, Geert-Jan,  (2021). 
The preprint version of this paper is available at SSRN: https://ssrn.com/abstract=3871676 or http://dx.doi.org/10.2139/ssrn.3871676 

## Introduction
Inside of this repository you can find:
- *The data generated for the experimnents in the paper.*
- *The code to generate optimal age-based policies under given parameter.*
- *A user interface where data can be accessed by the end-user.*

## Content of Repository
The codes should be run in the following order:

'Part0-Functions.R': Functions that are needed to upload to R before running Part 1 and Part 2. 

'Part1-Generating-dataset.R': This code generates state space, time-to-failure distribution dependent values and cost dependent values. 

'Part2-Applying-Optimal-Policy.R': This code generates the optimal policy for the given state space and data from Part 1. 

'tool-int.Rdata': 

## Dependencies

**R** (Software for Statistical Computing): These codes are supported by R version 4.0.5. 

The following R packages are used in the development of the optimal age-based maintenance algorithm:
 ‘dplyr’, ‘plyr’, ‘data.table’. 

The following R packages are used in the user interface: 
‘shiny’, ‘shinydashboard’,  ‘dplyr’, ‘plyr’, ‘ggplot2’, ‘callr’, ‘shinyBS’, ‘shinyWidgets’, ‘DT’, ‘data.table’. 

You can contact to Ipek (i.dursun@tue.nl) for your questions of you encounter any issues.
