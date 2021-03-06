% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AnnotateChIA.R
\name{add_gene_annotation}
\alias{add_gene_annotation}
\title{Adds gene-specific annotations to chia.obj.}
\usage{
add_gene_annotation(chia.obj, values, label, representative.only = TRUE)
}
\arguments{
\item{chia.obj}{A chia object to annotate.}

\item{values}{A named vector containing the values to associate the
chia.obj with. Each element should be named with a gene symbol.}

\item{label}{The label the annotation should be given in the chia object.}

\item{representative.only}{If true, only gene representative nodes are
associated with the given values.}
}
\value{
The ChIA object with the added annotation.
}
\description{
Given a vector of gene symbols and a vector of values associated with
those genes, this function finds the nodes for all symbols and 
attaches the given annotation to it.
}

