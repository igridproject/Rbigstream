#' Get data object from storage
#' @description
#' read data from Bigstream storage via Bigstream storage API
#' This command support on Bigstream version 1.2 or more only
#'
#' @param storage_name storage name
#' @param id Object id
#' @param index get data by index
#' @param key get data by defined key  in storage

#' @return data in JSON format from Bigstream storage. Return lastest data if no id, index or key param
#'
#' @examples
#' \dontrun{
#' host <- "http://sample.bigstream.io"
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' bs.connect(host, token)
#'
#' #return lastest data
#' storage.getJSON(storage_name)
#'
#' # return data object 010000000000000258107ea7
#' storage.getJSON(storage_name,id="010000000000000258107ea7")
#'
#' # return data index 1 (1st data in storage)
#' storage.getJSON(storage_name,index=1)
#'
#' # return data by key defined
#' storage.getJSON(storage_name,key="")
#' }
#' @export
storage.getJSON <- local(
  function(storage_name,
           id=NULL,index=NULL,key=NULL) {
    if(is.null(bs.active.url))
      stop(bs.no.url)
    return(storage.get(storage_name,id,index,key,flatten=FALSE))
  }
, env = BS.env)
