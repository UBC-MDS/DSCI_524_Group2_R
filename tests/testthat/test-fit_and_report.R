require(testthat)
require(datasets)
require(mlbench)
require(caret)

test_fit_and_report <- function(){
  data <- data(PimaIndiansDiabetes)
  dataset <- PimaIndiansDiabetes
  x <- dataset[1:8][1:600,]
  y <- dataset$diabetes[1:600]
  xv <- dataset[1:8][600:786,]
  yv <- dataset$diabetes[600:786]
  result_c <- fit_and_report(x,y,xv,yv,'glm','classification')
  data("iris")
  x1<- iris[1:2][1:100,]
  x2<-iris[1:2][100:150,]
  y1<- iris$Petal.Length[1:100]
  y2<-iris$Petal.Length[100:150]
  result_r <- fit_and_report(x1,y1,x2,y2,'glm','regression')
  
  
  test_that("Invalid ouput length", {
    expect_equal(length(result_c), 2)
    expect_equal(length(result_r), 2)
  })
  
  test_that("Score should be in range 0 to 1", {
    expect_true(0<=result_c[1] & result_c[1]<=1)
    expect_true(0<=result_c[2] & result_c[2]<=1)
    expect_true(0<=result_r[1] & result_r[1]<=1)
    expect_true(0<=result_r[2] & result_r[2]<=1)
  })
  
  test_that("Error raising failed", {
    expect_error(fit_and_report(x,y,xv,yv,1), "Model 1 is not in caret's built-in library")
  })
  
}

test_fit_and_report()
