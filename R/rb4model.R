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
#' missing_val(mtcars, 'mean')
#'
#' @export
missing_val <- function(df, method) {

  # tests

  if(!is.data.frame(df)) {
    stop("Can only handle missing values in dataframes")
  }

  if(!method %in% c('delete', 'mean', 'regression')) {
    stop("Valid methods only include 'delete', 'mean', and 'regression'")
  }

  if (dim(df)[2]==0 | dim(df)[1]==0) {
    stop("Dataframe cannot be empty") # edge case
  }

  for (i in 1:ncol(df)){
    if (all(is.na(df[i]))){
      stop("Dataframe cannot have empty columns") # edge case
    }
  }

  # function

  if(method=='delete'){
    df[stats::complete.cases(df),]
  }

  else if(method=='mean'){
    mice::complete(mice::mice(df, m = 1, method = "mean", maxit = 1, printFlag = FALSE))
  }

  else if(method=='regression'){
    mice::complete(mice::mice(df, method = "norm.predict", seed = 1, m = 1, print = FALSE))
  }

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
fit_and_report <- function(X, y, Xv, yv, method, m_type = 'regression'){
  try(if (class(m_type) !='character')
    stop('The m_type argument should be either regression or classificaition'))
  
  try(if(dim(X)[1] != length(y))
    stop('The length of X and y should be the same'))
  
  try(if(dim(Xv)[1]!= length(yv))
    stop('The length of Xv and yv should be the same'))
  
  
  if (startsWith(tolower(m_type), 'regress')){
    metric <- 'RMSE'
    model <- train(X, y, method=method, metric=metric)
    testPred <- predict(model, Xv)
    test_acc <- postResample(testPred, yv)
    errors <- c(1 - model$results$RMSE, 1 - test_acc[1] )
  }
  if (startsWith(tolower(m_type), 'classif')){
    metric <-'Accuracy'
    model<- train(X, y, method=method, metric=metric)
    testPred <- predict(model, Xv)
    test_acc <- postResample(testPred, yv)
    errors <- c(1 - model$results$Accuracy, 1 -test_acc[1]) 
  }
  return(errors)
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
