#' Show storage list
#' @description
#' Given storage list from current connection setup or given connection
#'
#' @return Storage list in give Bigstream connection
#'
#' @examples
#' host <- "http://sample.bigstream.io"
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' bs.connect(host, token)
#' storage.list()
#'
#' @export
storage.list <- local(
  function() {
    cat("call Bigstreram API -> ",bs.active.url,"\n")
    json <- request(bs.active.url)
    jsonlite::fromJSON(json,simplifyVector = TRUE)
  }
, env = BS.env)
