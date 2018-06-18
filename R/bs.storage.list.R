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
#' bs.connect(host, storage_name, token)
#' storage.list()
#'
#' @export
storage.list <- local(
  function() {
    url <- ""
    if(!is.null(conn))
      url <- conn
    else {
      if(is.null(bs.active.url))
        stop(bs.no.url)
      url <- bs.active.url
    }
    cat("call Bigstreram API -> ",url,"\n")
    json <- request(url)
    jsonlite::fromJSON(json,simplifyVector = TRUE)
  }
, env = BS.env)
