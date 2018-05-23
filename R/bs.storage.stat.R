#' Get storage information
#'
#' @param storage_name storage name
#'
#' @return Storage information
#'
#' @examples
#' host <- "http://sample.bigstream.io"
#' port <- 19080
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' conn <- bs.connect(host, port, token)
#' storage.stat(storage_name)
#' @export
storage.stat <- local(
  function(storage_name) {
    if(is.null(bs.active.url))
      stop(bs.no.url)
    bs.active.url <- paste(bs.active.url, storage_name, "stats",sep = "/")
    if(!RCurl::url.exists(bs.active.url))
      stop("Cannot connnect to Bigstream via ", bs.active.url)
    jsonlite::read_json(bs.active.url,simplifyVector = TRUE)
  }
, env = BS.env)
