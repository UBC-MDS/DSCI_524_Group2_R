library(testthat)
library(rb4model)

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
    
      
}

test_check("rb4model")
