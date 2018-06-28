#' Save data to storage
#' @description
#' This function replace data on given Bigstream Storage name.
#' @param storage_name target storage to put data
#' @param x data frame object
#'
#' @return save status
#'
#' @examples
#' \dontrun{
#' host <- "http://sample.bigstream.io"
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' bs.connect(host, token)
#' }
#' @export

storage.save <- local(
  function(storage_name,x) {
    if(!is.data.frame(x)) stop("x must be data frame type")

    # This function need API version 1.1 or more
    if(is.null(bs.active.url))
      stop(bs.active.url)
    url <- paste(bs.active.url, storage_name,sep = "/")

    # Remove data first
    json <- request(url,opt="DELETE")
    #object <- jsonlite::fromJSON(json)
    #if(!(object=="OK"))
      #stop(object)
    storage.put(storage_name,x)
  }
  , env = BS.env)









