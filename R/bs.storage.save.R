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
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' conn <- bs.connect(host, storage_name, token)
#' @export

storage.save <- local(
  function(storage_name,x) {
    if(!is.data.frame(x)) stop("x must be data frame type")

    # This function need API version 1.1 or more
    if(is.null(bs.active.url))
      stop(bs.active.url)
    url <- paste(bs.active.url, storage_name,sep = "/")

    # Remove data first
    h <- httr::handle(url)
    req <- httr::DELETE(URL=NULL,handle = h)
    httr::stop_for_status(req,paste("Cannot connnect to Bigstream via ", url))
    json <- httr::content(req, "text")

    object <- jsonlite::fromJSON(json)
    if(!(object=="OK"))
      stop(object)
    rm(h)
    storage.put(storage_name,x)
  }
  , env = BS.env)









