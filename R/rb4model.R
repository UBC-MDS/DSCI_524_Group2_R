#' Handles missing values
#'
#' Replaces or deletes missing values in a dataframe
#'
#' @param df dataframe with missing values
#' @param method string ('delete' deletes row with missing values, 'avg' replaces missing value with the average, 'last' replaces missing value with the last observation)
#'
#' @return dataframe without missing values
#'
#' @examples
#' missing_val(df, 'last')
#'
#' @export
missing_val <- function(df, method) {
  # INSERT CODE HERE
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



# Feature Selection

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
ForwardSelection <- function(model, feature, label, min_f=1, max_f=NA, cv=3, type="regression"){
  
  # define maximum amount of features
  if(is.na(a)){
    max_f <- dim(feature)[2]
  }
  
  # test
  
  # create empty vector
  ftr <- c()
  # total number of features
  tot <- seq(dim(feature))
  # total list of features
  total_features <- seq(length(feature))
  # Initialize error
  best_score <- -Inf
  
  while(length(ftr) < max_f){
    # remove already selected features
    unselected <- setdiff(tot, ftr)
    candidate <- c()
    
    for(feature in unselected){
      # fit model
      ...
      ...
      ...
      if(eval_score > best_score){
        best_score <- eval_score
        candidate <- feature
      }
      
    if(!is.na(candidate)){
        ftr <- c(ftr,candidate)
    } else {
      break
    }
    
    
  }
  
}
