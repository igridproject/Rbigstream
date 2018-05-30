#' Save data to storage
#' @description
#' This function replace data on given Bigstream Storage name.
#' @param storage_name target storage to put data
#' @param x data frame object
#'
#' @return save status
#'
#' @examples
#' host <- "http://sample.bigstream.io"
#' port <- 19080
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' conn <- bs.connect(host, port, token)
#' storage.save(storage_name,x)
#' @export

storage.save <- local(
  function(storage_name,x) {
    if(!is.data.frame(x)) stop("x must be data frame type")

    # This function need API version 1.1 or more
    if(is.null(bs.active.url.v1.1))
      stop(bs.active.url.v1.1)
    bs.active.url <- paste(bs.active.url.v1.1, storage_name,sep = "/")

    # Remove data first
    h <- httr::handle(bs.active.url)
    req <- httr::DELETE(URL=NULL,handle = h)
                    #    ,httr::add_headers(.headers = c("Content-Type"="application/json","User-Agent"="Rbigstream")))
    httr::stop_for_status(req,paste("Cannot connnect to Bigstream via ",bs.active.url, " or current bigstream version does not support storage.put command"))
    json <- httr::content(req, "text")

    object <- jsonlite::fromJSON(json)
    if(!(object=="OK"))
      stop(object)
    rm(h)
    storage.put(storage_name,x)
  }
  , env = BS.env)









