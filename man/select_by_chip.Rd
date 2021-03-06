% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/OperationsChIA.R
\name{select_by_chip}
\alias{select_by_chip}
\title{Returns a subset of a ChIA object containing only nodes with the specified 
transcription factors.}
\usage{
select_by_chip(chia.obj, chip.names)
}
\arguments{
\item{chia.obj}{The ChIA object whose regions must be assessed.}

\item{chip.names}{The ChIP whose regions must be returned.}
}
\value{
A subset of the ChIA object containing only nodes with the specified 
  ChIPs.
}
\description{
Returns a subset of a ChIA object containing only nodes with the specified 
transcription factors.
}

