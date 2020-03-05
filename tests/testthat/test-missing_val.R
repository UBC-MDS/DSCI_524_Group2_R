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
