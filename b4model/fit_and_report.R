         
    #' @param model -- A machine learning model, can either be classification or regression
    #'
    #' @param X --  The features of the training set
    #'
    #' @param y -- The target of the training set
    #'
    #' @param Xv -- The feature of the validation set
    #'
    #' @param yv -- The target of the validation set
    #'
    #' @param m_type-- The type for calculating error (default = 'regression') 
    #'
    #' @return an array of train and validation error
    #'
    #' @description: fits a model and returns the train and validation errors as a list
    #'
    #' @examples
    #'fit_and_report(logistic_regression, X, y, Xv, yv)    
    fit_and_report <- function(model, X, y, Xv, yv, m_type = 'regression'){
       }