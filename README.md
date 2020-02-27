# rb4model Python Package

## Summary

This project aims to build an R and Python package that elegently performs data pre-processing in a fast and easy manner.With four separate functions that will come along with the b4prep package, users will have greater flexibility in handling many different types of datasets in the wild or those collected by them. With b4prep package, users will be able to smoothly pre-process their data and have it ready for the machine learning model of their choice.

## Functions
### Handling Missing Values
- This function will take in a dataframe and handle any missing values by either deleting the row, filling in the value with the average, or filling in the value with the last observation (the user will specify which method to use in the function argument).
- This function will return a dataframe without missing values.

### Split and Scale
- This function will take in a dataframe and split the data into numerical and categorical features.
- This function will return two lists, one list containing the names of the numerical features and one list containing the names of the categorical features.

### Fit and Report
- This function will take in a dataframe, fit a model, and calculate its training and testing scores.
- This function will return the model's training and testing scores.

### Forward Feature Selection
- This function will take in a dataframe, fit a model, and perform forward feature selection.
- This function will return a dataframe with only the selected features.

## Python Ecosystem
