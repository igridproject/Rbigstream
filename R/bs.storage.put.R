#' Put data to storage
#' @param storage_name target storage to put data
#' @param x data frame object
#'
#' @return put status
#'
#' @examples
#' host <- "http://sample.bigstream.io"
#' port <- 19080
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' conn <- bs.connect(host, port, token)
#' storage.put(storage_name,x)
#' @export

storage.put <- local(
  function(storage_name,x) {
    if(!is.data.frame(x)) stop("x must be data frame type")

    # This function need API version 1.1 or more
    if(is.null(bs.active.url.v1.1))
      stop(bs.no.url)
    bs.active.url <- paste(bs.active.url.v1.1, storage_name,sep = "/")
    # if(!RCurl::url.exists(bs.active.url))
    #  stop("Cannot connnect to Bigstream via ", bs.active.url, " or current bigstream version does not support storage.put command")

    .meta_list <- list("User-Agent" = "Rbigstream" ,  version="0.1", timestamp = as.integer(as.POSIXct(Sys.time())))
    meta <- list(meta = .meta_list)

    # eg. body <- '{ "meta":{ "Rbigstream-version":"0.1","User-Agent":"Rbigstream" } , "data": { "name":"krit002"}   }'
    .body <- ""
    for(row in 1:nrow(x)){
      .tmp <- as.list(t(x)[,row])
      names(.tmp) <- colnames(x)
      .data <- list(.tmp)
      .object <- c(meta,data=.data)
      .body <- paste(.body,jsonlite::toJSON(.object,auto_unbox = TRUE), sep=",")
    }
    rm(.data)
    rm(.object)

    .body <- substring(.body,2)
    .body <- paste("[",.body,"]",sep = "")

    if(!jsonlite::validate(.body)) stop()
    req <- httr::PUT(bs.active.url,
               body = .body ,
               httr::add_headers(.headers = c("Content-Type"="application/json","User-Agent"="Rbigstream")))
    httr::stop_for_status(req,paste("Cannot connnect to Bigstream via ", bs.active.url, " or current bigstream version does not support storage.put command"))
    json <- httr::content(req, "text")

    object <- jsonlite::fromJSON(json)
    if(object=="OK")
      cat("Put data successfully.\n")
  }
  , env = BS.env)









