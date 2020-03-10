#' Testing ForwardSelection
#'
#' assert that length of selected features is smaller than total number of features
#' assert that selected features performs better than model with all features
#' 
test_ForwardSelection<- function(){

  # Setting
  y <- mtcars$mpg
  x <- mtcars[,-1]
  selected <- ForwardSelection(my_mod="lm", feature=x, label=y, type="regression", cv=5)

  train_control <- caret::trainControl(method="cv", number=5)
  ffs_model <- caret::train(x=x[selected], y=y, trControl = train_control, method ="lm", metric="RMSE")
  control_model <- caret::train(x=x, y=y, trControl = train_control, method ="lm", metric="RMSE")

  ffs_score <- as.double(ffs_model$results["RMSE"])
  control_score <- as.double(control_model$results["RMSE"])

  # Test

  test_that('length of selected features should not be greater than the total number of features', {
    expect_less_than(length(selected), length(x))
  })

  test_that('forward selected features should have the best score', {
    expect_less_than(ffs_score, control_score)
  })
}

test_ForwardSelection()
