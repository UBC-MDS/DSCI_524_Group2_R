require(testthat)

#' Test for feature_splitter_function to split a data frame into two components by features
#' The output being a tupple containing two list of categegorical features and numerical features
#' Errors & exceptions will be raised if tests do not pass
#'
#' @export

test_feature_splitter <- function() {
  Name <- c('John', 'Micheal', 'Lindsey', 'Adam')
  Age<-c(40, 22, 39, 15)
  Height<-c(1.70, 1.82, 1.77, 1.69)
  Anual_Salary<-c(40000, 65000, 70000, 15000)
  Nationality<-c('Canada', 'USA', 'Britain', 'Australia')
  Marital_Status<-c('Married', 'Single', 'Maried', 'Single')

  data <-data.frame(Name, Age, Height, Anual_Salary,Nationality, Marital_Status)

  test_that("Result of function MUST be a dataframe of two columns", {
    expect_equal(length(feature_splitter(data)), 2)})
  test_that("Test that total number of categorical and numerical features is same as column names in the data frame",{
    expect_equal(nrow(feature_splitter(data)),length(sort(colnames(data))))})
}

test_feature_splitter()
