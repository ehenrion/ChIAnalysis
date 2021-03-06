% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/OperationsChIA.R
\name{category_apply}
\alias{category_apply}
\title{Applies a function to a set chia object subsets.}
\usage{
category_apply(chia.obj, chia.function, node.categories, ...)
}
\arguments{
\item{chia.obj}{The chia object on which the functions must be applied.}

\item{chia.function}{The function to be applied to all given subsets of the chia object.}

\item{node.categories}{A data-frame with a number of rows equal to the number of regions
in chia.obj, where each column represents a set of indices indicating which nodes belong
in a givenc ategory.}
}
\value{
A list containing th results of the calls to chia.function.
}
\description{
For each column of node.categories, generates a subset of chia.obj and applies chia.function.
The results of all calls are returned in a named list.
}

