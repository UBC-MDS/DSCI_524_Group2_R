
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

`missing_val`

  - This function will take in a dataframe and handle any missing values
    by either deleting the row, filling in the value with the average,
    or filling in the value with the last observation (the user will
    specify which method to use in the function argument).
  - This function will return a dataframe without missing values.

`feature_splitter`

  - This function will take in a dataframe and split the data into
    numerical and categorical features.
  - This function will return two lists, one list containing the names
    of the numerical features and one list containing the names of the
    categorical features.

`fit_and_report`

  - This function will take in data, fit a model, and calculate its
    training and validation scores.
  - This function will return the model’s training and validation
    scores.

`ForwardSelection`

  - This function will take in data, fit a model, and perform forward
    feature selection.
  - This function will return a dataframe with only the selected
    features.

## Usage

This is a basic example which shows you how to solve a common machine
learning problem.

``` r
library(rb4model)
```

Let’s work with the iris dataset.

``` r
iris_copy <- iris
iris_copy[1,1]<-NA
head(iris_copy)
```

    ##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ## 1           NA         3.5          1.4         0.2  setosa
    ## 2          4.9         3.0          1.4         0.2  setosa
    ## 3          4.7         3.2          1.3         0.2  setosa
    ## 4          4.6         3.1          1.5         0.2  setosa
    ## 5          5.0         3.6          1.4         0.2  setosa
    ## 6          5.4         3.9          1.7         0.4  setosa

Use the `missing_val` function to fill in any missing values in your
dataframe.

``` r
head(missing_val(df=iris_copy, method='mean'))
```

    ##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ## 1     5.848322         3.5          1.4         0.2  setosa
    ## 2     4.900000         3.0          1.4         0.2  setosa
    ## 3     4.700000         3.2          1.3         0.2  setosa
    ## 4     4.600000         3.1          1.5         0.2  setosa
    ## 5     5.000000         3.6          1.4         0.2  setosa
    ## 6     5.400000         3.9          1.7         0.4  setosa

Use the `feature_splitter` function to split your data into categorical
and numerical features.

``` r
feature_splitter(iris)
```

    ## [[1]]
    ## [1] "Species"
    ## 
    ## [[2]]
    ## [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"

Use the `fit_and_report` function to fit a machine learning model of
choice and report its training and validation score.

``` r
x1<- iris[1:2][1:100,]
x2<-iris[1:2][100:150,]
y1<- iris$Petal.Length[1:100]
y2<-iris$Petal.Length[100:150]
fit_and_report(x1,y1,x2,y2,'glm','regression')
```

    ## Loading required package: lattice

    ## Loading required package: ggplot2

    ##                  RMSE 
    ## 0.44201045 0.08478573

Use the `ForwardSelection` function to perform forward feature selection
on your data. Then subset your original dataframe with the selected
features.

``` r
y <- iris$Species
x <- iris[c(1,2,3,4)]
ffs <- ForwardSelection(feature=x, label=y, my_mod="rf")
```

    ## note: only 1 unique complexity parameters in default grid. Truncating the grid to 1 .
    ## 
    ## note: only 1 unique complexity parameters in default grid. Truncating the grid to 1 .
    ## 
    ## note: only 1 unique complexity parameters in default grid. Truncating the grid to 1 .

``` r
head(x[ffs])
```

    ##   Sepal.Width
    ## 1         3.5
    ## 2         3.0
    ## 3         3.2
    ## 4         3.1
    ## 5         3.6
    ## 6         3.9

## Dependencies

| Package                                                                              | Version |
| ------------------------------------------------------------------------------------ | ------- |
| [mice](https://cran.r-project.org/web/packages/mice/index.html)                      | 3.7.0   |
| [stats](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/00Index.html)       | 4.0.0   |
| [testthat](https://cran.r-project.org/web/packages/testthat/index.html)              | 2.1.0   |
| [caret](https://cran.r-project.org/web/packages/caret/index.html)                    | 6.0-85  |
| [datasets](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html) | 4.0.0   |
| [mlbench](https://cran.r-project.org/web/packages/mlbench/index.html)                | 2.1-1   |
| [randomForest](https://cran.r-project.org/web/packages/randomForest/index.html)      | 4.6-14  |
| [e1071](https://cran.r-project.org/web/packages/e1071/index.html)                    | 1.7-3   |
| [plyr](https://cran.r-project.org/web/packages/plyr/index.html)                      | 1.8.6   |

## R Ecosystem

`caret` is probably the most widely used package for supervised learning
problems in R. Although the library provides various model fitting and
preprocessing features, programmers end up with writing the same line of
code over and over again. Our `rb4model` library provides a simple
solution to this pain point: wrapper functions of `caret` and other
primary libraries used for supervised learning to reduce lines of code
and promote efficiency.

## Documentation

The vignette is hosted
[here](https://ubc-mds.github.io/rb4model/articles/my-vignette.html).
