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
#' @param data dataframe
#' @return a tuple
#'
#' @examples
#' feature_splitter(mtcars)
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




# Feature Selection

#' Implement forward feature selection and return data with selected features
#' Uses root mean squared error for regression and accuracy for classification
#'
#' @param my_mod model name in string (must be in caret::modelLookup())
#' @param feature training dataset with features
#' @param label training dataset with labels.
#' @param min_f minimum amount of features to select
#' @param max_f maximum amount of features to select
#' @param type problem type. (Must be 'regression' or 'classification')
#' @param cv number of folds for cross validation
#'
#' @return The dataset with selected features.
#' @examples
#'
#' y <- iris$Species
#' x <- iris[c(1,2,3,4)]
#' ffs <- ForwardSelection(feature=x, label=y, my_mod="rf")
#' print(x[ffs])
#'
#' @export
ForwardSelection <- function(my_mod, feature, label, max_f=NA, type="classification", cv=3){

  # define maximum amount of features
  if(is.na(max_f)){
    max_f <- dim(feature)[2]
  }

  # test
  if(!all.equal(max_f, as.integer(max_f))){
    stop("maximum number of features should be an integer")
  }
  if(!type %in% c("regression","classification")){
    stop("problem should be 'regression' or 'classification'")
  }
  if(!all.equal(cv, as.integer(cv))){
    stop("number of folds for cross validation should be an integer")
  }
  if(!my_mod %in% names(caret::getModelInfo())){
    stop("your model should be supported by caret")
  }
  # if(!is.double(label)){
  #   stop("label should be a vector of double")
  # }
  if(!is.list(feature)){
    stop("feature should be a list")
  }
  # define the problem & set the metric/scoring method
  if(type == "regression"){
  metric = "RMSE"
  } else {
  metric = "Accuracy"
  }

  # create empty vector
  ftr <- c()
  # total list of features
  tot <- seq(length(feature))
  # Initialize error
  best_score <- -Inf


  while(length(ftr) < max_f){
    # remove already selected features
    unselected <- setdiff(tot, ftr)
    candidate <- NULL

    for(f in unselected){
      temp_f <- c(ftr,f)

      train_control <- caret::trainControl(method="cv", number=cv)
      model <- caret::train(x=feature[,temp_f, drop=FALSE], y=label, trControl = train_control, method=my_mod, metric=metric)

      # score
      eval_score <- as.double(model$results[metric])
      eval_score <- -eval_score

      # update score
      if(eval_score > best_score){
        best_score <- eval_score
        candidate <- f
      }
    }

    if(!is.null(candidate)){
      ftr <- c(ftr,candidate)
    } else {
      break
    }

  }
  return(ftr)
}






#' Fit and report
#'
#' @param X The features of the training set
#' @param y The target of the training set
#' @param Xv The feature of the validation set
#' @param yv The target of the validation set
#' @param method A machine learning model, can either be classification or regression
#' @param m_type The type for calculating error (default = 'regression')
#'
#' @return an array of train and validation error
#'
#' @description: fits a model and returns the train and validation errors as a list
#'
#' @examples
#' x1<- iris[1:2][1:100,]
#' x2<-iris[1:2][100:150,]
#' y1<- iris$Petal.Length[1:100]
#' y2<-iris$Petal.Length[100:150]
#' result_r <- fit_and_report(x1,y1,x2,y2,'glm','regression')
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
    model <- caret::train(X, y, method=method, metric=metric)
    testPred <- stats::predict(model, Xv)
    test_acc <- caret::postResample(testPred, yv)
    errors <- c(1 - model$results$RMSE, 1 - test_acc[1] )
  }
  if (startsWith(tolower(m_type), 'classif')){
    metric <-'Accuracy'
    model<- caret::train(X, y, method=method, metric=metric)
    testPred <- stats::predict(model, Xv)
    test_acc <- caret::postResample(testPred, yv)
    errors <- c(1 - model$results$Accuracy, 1 -test_acc[1])
  }
  return(errors)
}

