#' Handles missing values
#'
#' Replaces or deletes missing values in a dataframe
#'
#' @param df dataframe with missing values
#' @param method string ('delete' removes rows with missing values, 'mean' replaces missing values with averages, 'regression' replaces missings value with fitted values)
#'
#' @return dataframe without missing values
#'
#' @examples
#' missing_val(df, 'mean')
#'
#' @export
test_missing_val <- function() {

  test_that('regression imputation should replace missing value with fitted value', {
    expect_equal(missing_val(airquality, 'regression')$Ozone[5], -11.7682028889364, tolerance=1e-5)
  })
    
  test_that('mean imputation should replace missing value with average', {
    expect_equal(missing_val(airquality, 'mean')$Ozone[5], mean(airquality$Ozone, na.rm=TRUE))
  })
    
  test_that('listwise deletion should remove rows with missing values', {
    expect_equal(nrow(missing_val(airquality, 'delete')), 111)
  })
    
  test_that('should throw error', {
    expect_error(missing_val('a', 'delete'), 'Can only handle missing values in dataframes')
  })
    
  test_that('should throw error', {
    expect_error(missing_val(airquality, 'del'), "Valid methods only include 'delete', 'mean', and 'regression")
  })
    
  airquality_empty <- airquality
  airquality_empty <- NULL
  airquality_empty <- data.frame(airquality_empty)
  test_that('should throw error', {
    expect_error(missing_val(airquality_empty, 'delete'), "Dataframe cannot be empty")
  })
    
  airquality_empty <- airquality
  airquality_empty$'empty' <- NA
  test_that('should throw error', {
    expect_error(missing_val(airquality_empty, 'delete'), "Dataframe cannot have empty columns")
  })
    
}


#' feature_splitter function Documentation
#' Splits dataset column names into a tuple of categorical and numerical lists
#'
#' @param x
#' @return a tuple
#'
#' @examples
#' feature_splitter(data)
#' ([categorical:],[numerical: ])
#'
#' @export
feature_splitter<-function(x){
  #TODO

}


#' Fit and report
#'
#' @param model A machine learning model, can either be classification or regression
#' @param X The features of the training set
#' @param y The target of the training set
#' @param Xv The feature of the validation set
#' @param yv The target of the validation set
#' @param m_type The type for calculating error (default = 'regression')
#'
#' @return an array of train and validation error
#'
#' @description: fits a model and returns the train and validation errors as a list
#'
#' @examples
#'
#' @export
fit_and_report <- function(model, X, y, Xv, yv, m_type = 'regression'){
}


# Title     : Feature Selection
# Objective : Implement forward feature selection and return data with selected features
# Created by: nowgeun
# Created on: 2020-02-26

#' Implement forward feature selection and return data with selected features
#'
#' @param X training dataset with features
#' @param y training dataset with labels.
#' @param min_feat minimum amount of features to select
#' @param max_feat maximum amount of features to select
#'
#'
#' @return The dataset with selected features.
#' @examples
#' add(1, 1)
#' add(10, 1)
#'
#' @export
ForwardSelection <- function(X,y,min_feat=1, max_feat=30){

}
