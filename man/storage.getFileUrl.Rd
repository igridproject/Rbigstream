% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bs.storage.getFileUrl.R
\name{storage.getFileUrl}
\alias{storage.getFileUrl}
\title{Get data object from storage}
\usage{
storage.getFileUrl(storage_name, id = NULL, index = NULL, key = NULL,
  type = "dat")
}
\arguments{
\item{storage_name}{storage name}

\item{id}{Object id}

\item{index}{get data by index}

\item{key}{get data by defined key  in storage}

\item{type}{file format return default is csv}
}
\value{
url for download object
}
\description{
read data from Bigstream storage via Bigstream storage API
This command support on Bigstream version 1.2 or more only
}
\examples{
\dontrun{
host <- "http://sample.bigstream.io"
storage_name <- "sample.sensordata"
token <- "token"
bs.connect(host, token)

#return lastest data as csv
url <- storage.getFileUrl(storage_name)
read.csv(url, header=FALSE, sep="|")
}
}
