% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bs.connect.R
\name{bs.connect}
\alias{bs.connect}
\title{Setup Bigstream connector function}
\usage{
bs.connect(host, port = 19080, storage_name = NULL, token)
}
\arguments{
\item{host}{Bigstream Service host.}

\item{port}{Bigstream API Port (Default : 19080)}

\item{storage_name}{Set storage name}

\item{token}{Set API token}
}
\value{
connection setting
}
\description{
Setup Bigstream connector function
}
\examples{
host <- "http://sample.bigstream.io"
port <- 19080
storage_name <- "sample.sensordata"
token <- "token"
conn <- bs.connect(host, port, token)
}