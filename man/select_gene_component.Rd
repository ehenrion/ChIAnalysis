% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/OperationsChIA.R
\name{select_gene_component}
\alias{select_gene_component}
\title{Select all nodes in the components where the given genes are found.}
\usage{
select_gene_component(chia.obj, genenames)
}
\arguments{
\item{chia.obj}{A list containing the ChIA-PET data, as returned by \code{\link{load_chia}}.}

\item{genenames}{A vector fo gene names whose components should be selected.}
}
\value{
A subset fo chia.obj containing only the components of the given genes.
}
\description{
Select all nodes in the components where the given genes are found.
}

