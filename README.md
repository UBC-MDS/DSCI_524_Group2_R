
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rb4model R Package

<!-- badges: start -->

![CI](https://github.com/UBC-MDS/rb4model/workflows/CI/badge.svg)
[![Codecov test
coverage](https://codecov.io/gh/UBC-MDS/rb4model/branch/master/graph/badge.svg)](https://codecov.io/gh/UBC-MDS/rb4model?branch=master)
[![R build
status](https://github.com/UBC-MDS/rb4model/workflows/R-CMD-check/badge.svg)](https://github.com/UBC-MDS/rb4model/actions)
<!-- badges: end -->

## Summary

This project aims to build an R package that elegantly performs data
pre-processing in a fast and easy manner. With four separate functions
that will come along with the rb4model package, users will have greater
flexibility in handling many different types of datasets in the wild or
those collected by them. With the rb4model package, users will be able
to smoothly pre-process their data and have it ready for the machine
learning model of their choice.

## Installation

It is recommended that `rb4model` be installed via `devtools`.

    devtools::install_github("UBC-MDS/rb4model")

## Functions

`missing_val` - This function will take in a dataframe and handle any
missing values by either deleting the row, filling in the value with the
average, or filling in the value with the last observation (the user
will specify which method to use in the function argument). - This
function will return a dataframe without missing values.

`feature_splitter` - This function will take in a dataframe and split
the data into numerical and categorical features. - This function will
return two lists, one list containing the names of the numerical
features and one list containing the names of the categorical features.

`fit_and_report` - This function will take in data, fit a model, and
calculate its training and validation scores. - This function will
return the model’s training and validation scores.

`ForwardSelection` - This function will take in data, fit a model, and
perform forward feature selection. - This function will return a
dataframe with only the selected features.

## Usage

This is a basic example which shows you how to solve a common machine
learning problem (missing values in data):

``` r
library(rb4model)
head(airquality)
```

    ##   Ozone Solar.R Wind Temp Month Day
    ## 1    41     190  7.4   67     5   1
    ## 2    36     118  8.0   72     5   2
    ## 3    12     149 12.6   74     5   3
    ## 4    18     313 11.5   62     5   4
    ## 5    NA      NA 14.3   56     5   5
    ## 6    28      NA 14.9   66     5   6

``` r
head(missing_val(df=airquality, method='mean'))
```

    ##      Ozone  Solar.R Wind Temp Month Day
    ## 1 41.00000 190.0000  7.4   67     5   1
    ## 2 36.00000 118.0000  8.0   72     5   2
    ## 3 12.00000 149.0000 12.6   74     5   3
    ## 4 18.00000 313.0000 11.5   62     5   4
    ## 5 42.12931 185.9315 14.3   56     5   5
    ## 6 28.00000 185.9315 14.9   66     5   6

## Dependencies

| Package      | Version |
| ------------ | ------- |
| mice         | 3.7.0   |
| stats        | 4.0.0   |
| testthat     | 2.1.0   |
| caret        | 6.0-85  |
| datasets     | 4.0.0   |
| mlbench      | 2.1-1   |
| randomForest | 4.6-14  |
| e1071        | 1.7-3   |

## R Ecosystem

`caret` is probably the most widely used package for supervised learning
problems in R. Although the library provides various model fitting and
preprocessing features, programmers end up with writing the same line of
code over and over again. Our `rb4model` library provides a simple
solution to this pain point: wrapper functions of `caret` and other
primary libraries used for supervised learning to reduce lines of code
and promote efficiency.
