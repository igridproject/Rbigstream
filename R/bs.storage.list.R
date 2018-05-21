#' Show storage list
#' @description
#' Given storage list from current connection setup or given connection
#'
#' @param conn Bigstream connection (No need if already call bs.connect() )
#'
#' @return Storage list in give Bigstream connection
#'
#' @examples
#' host <- "http://sample.bigstream.io"
#' port <- 19080
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' conn <- bs.connect(host, port, token)
#' storage.list()
#'
#' or
#'
#' storage.list(conn)
#' @export
storage.list <- local(
  function(conn = NULL) {
    url <- ""
    if(!is.null(conn))
      url <- conn
    else {
      if(is.null(bs.active.url))
        stop(bs.no.url)
      url <- bs.active.url
    }
    if(!RCurl::url.exists(url))
      stop("Cannot connnect to Bigstream via ", url)
    cat("call Bigstreram API -> ",url,"\n")
    jsonlite::read_json(url,simplifyVector = TRUE)
  }
, env = BS.env)
