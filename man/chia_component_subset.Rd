% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/OperationsChIA.R
\name{chia_component_subset}
\alias{chia_component_subset}
\title{Subset a chia object by keeping all components where at least one node is selected.}
\usage{
chia_component_subset(chia.obj, indices, min.selection = 1)
}
\arguments{
\item{chia.obj}{The chia object to be subset.}

\item{indices}{The indices of the vertices to be kept.}
}
\value{
A chia object containing only the selected vertices.
}
\description{
Subset a chia object by keeping all components where at least one node is selected.
}

