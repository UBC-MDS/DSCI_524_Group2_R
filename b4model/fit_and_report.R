library(mlbench)
library(caret)
    #' @param X --  The features of the training set
    #'
    #' @param y -- The target of the training set
    #'
    #' @param Xv -- The feature of the validation set
    #'
    #' @param yv -- The target of the validation set
    #'
    #' @param method -- The machine learning method applied 
    #'
    #' @param m_type-- The type for calculating error (default = 'regression') 
    #'
    #' @return an array of train and validation error
    #'
    #' @description: fits a specified model and report the train and test error, only supports model supported by mblench package
    #'
    #' @examples
    #'fit_and_report(logistic_regression, X, y, Xv, yv, method ='glm', m_type = 'classification') 
    #'   
fit_and_report <- function(X, y, Xv, yv, method, m_type = 'regression'){
    if (class(m_type) !='character'){
        return(exception('The m_type argument should be either regression or classificaition'))
    }
    if(len(X) != len(y)){
        return(exception('The length of X and y should be the same'))
    }
    if(len(Xv) != len(yv)){
        return(exception('The length of Xv and yv should be the same'))
    }
    
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