#' Put data to storage
#' @param storage_name target storage to put data
#' @param x data frame object
#'
#' @return put status
#'
#' @examples
#' host <- "http://sample.bigstream.io"
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' bs.connect(host, storage_name, token)
#' storage.put(storage_name,x)
#' @export

storage.put <- local(
  function(storage_name,x) {
    # This function need API version 1.1 or more
    if(is.null(bs.active.url))
      stop(bs.active.url)
    url <- paste(bs.active.url, storage_name,sep = "/")
    # if(!RCurl::url.exists(url))
    #  stop("Cannot connnect to Bigstream via ", url , " or current bigstream version does not support storage.put command")


    .meta_list <- list("User-Agent" = "Rbigstream" ,  version="0.1", timestamp = as.integer(as.POSIXct(Sys.time())))
    meta <- list(meta = .meta_list)

    if(is.data.frame(x)) { #stop("x must be data frame type")
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
    } else {
      .body <- ""
      .body <- c(meta,list(data=x))
      .body <- jsonlite::toJSON(.body ,auto_unbox = TRUE)
    }
    if(!jsonlite::validate(.body)) stop()
    json <- request(url,.body,"PUT")
    object <- jsonlite::fromJSON(json)
    if(object=="OK")
      cat("Put data to ", url ,"Completed.\n")
  }
  , env = BS.env)









