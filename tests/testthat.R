library(testthat)
library(rb4model)

test_check("rb4model")

test_fit_and_report <- function(){
  data <- data(PimaIndiansDiabetes)
  dataset <- PimaIndiansDiabetes
  x <- dataset[1:8][1:600,]
  y <- dataset$diabetes[1:600]
  xv <- dataset[1:8][600:786,]
  yv <- dataset$diabetes[600:786]
  result <- fit_and_report(x,y,xv,yv,'glm','classification')
  print(result)
  
  test_that("Invalid ouput length", {
    expect_equal(length(result), 2)
  })
  
  test_that("Score should be in range 0 to 1", {
    expect_equal(length(result), 2)
  })
  
  test_that("Error raising failed", {
    expect_error(fit_and_report(x,y,xv,yv,1), "Model 1 is not in caret's built-in library")
  })
  
}