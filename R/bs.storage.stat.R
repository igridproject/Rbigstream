#' Get storage information
#'
#' @param storage_name storage name
#'
#' @return Storage information
#'
#' @examples
#' host <- "http://sample.bigstream.io"
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' bs.connect(host, storage_name, token)
#' storage.stat(storage_name)
#' @export
storage.stat <- local(
  function(storage_name) {
    if(is.null(bs.active.url))
      stop(bs.no.url)
    bs.active.url <- paste(bs.active.url, storage_name, "stats",sep = "/")
    json <- request(bs.active.url,opt="GET")
    jsonlite::fromJSON(json,simplifyVector = TRUE)
  }
, env = BS.env)
