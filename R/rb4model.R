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
feature_splitter<-function(data){
    # Checking if input data of the format of data frame
    if(class(data) != 'data.frame') stop("Warning: The input data MUST be of data frame format ")

    #Analysis data types of features in the data frame
    d_types <- sapply(data, class)

    #Extracting categorical features from the data
    categorical <- c(names(d_types[d_types == 'factor']))

    # Extracting numerical features from the data
    numerical <- c(names(d_types[d_types != 'factor']))
    
    if(length((list(categorical,numerical))) != 2) stop("The output MUST be a list of length 2 ")
    
    return (list(categorical,numerical))
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
