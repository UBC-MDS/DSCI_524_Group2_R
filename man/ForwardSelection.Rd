% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rb4model.R
\name{ForwardSelection}
\alias{ForwardSelection}
\title{Implement forward feature selection and return data with selected features
Uses root mean squared error for regression and accuracy for classification}
\usage{
ForwardSelection(
  my_mod,
  feature,
  label,
  max_f = NA,
  type = "classification",
  cv = 3
)
}
\arguments{
\item{my_mod}{model name in string (must be in caret::modelLookup())}

\item{feature}{training dataset with features}

\item{label}{training dataset with labels.}

\item{max_f}{maximum amount of features to select}

\item{type}{problem type. (Must be 'regression' or 'classification')}

\item{cv}{number of folds for cross validation}
}
\value{
The dataset with selected features.
}
\description{
Implement forward feature selection and return data with selected features
Uses root mean squared error for regression and accuracy for classification
}
\examples{

y <- iris$Species
x <- iris[c(1,2,3,4)]
ffs <- ForwardSelection(feature=x, label=y, my_mod="rf")
print(x[ffs])

}
