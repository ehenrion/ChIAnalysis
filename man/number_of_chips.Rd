% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AccessorsChIA.R
\name{number_of_chips}
\alias{number_of_chips}
\title{Obtain the number of histone marks from a given list that bind all regions within a ChIA-PET object.}
\usage{
number_of_chips(chia.obj, chip.names)
}
\arguments{
\item{chia.obj}{A ChIA-PET object.}

\item{histone.names}{The names of the histone marks to look for.}
}
\value{
An integer vector containing the number of histone marks in the list binding each region.
}
\description{
Obtain the number of histone marks from a given list that bind all regions within a ChIA-PET object.
}

