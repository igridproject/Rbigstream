#' Get data object from storage
#' @description
#' read data from Bigstream storage via Bigstream storage API
#' This command support on Bigstream version 1.2 or more only
#'
#' @param storage_name storage name
#' @param id Object id
#' @param index get data by index
#' @param key get data by defined key  in storage
#' @param flatten return in JSON format if this param is FALSE

#' @return data from Bigstream storage. Return lastest data if no id, index or key param
#'
#' @examples
#' host <- "http://sample.bigstream.io"
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' bs.connect(host, token)
#'
#' #return lastest data
#' storage.get(storage_name)
#'
#' # return data object 010000000000000258107ea7
#' storage.get(storage_name,id="010000000000000258107ea7")
#'
#' # return data index 1 (1st data in storage)
#' storage.get(storage_name,index=1)
#'
#' # return data by key defined
#' storage.get(storage_name,key="")
#' @export
storage.get <- local(
  function(storage_name,
           id=NULL,index=NULL,key=NULL,flatten=TRUE) {
    if(is.null(bs.active.url))
      stop(bs.no.url)

    # Version 1.2
    data.url <- paste(bs.url, "object" ,storage_name, sep = "/")
    if(!is.null(id)) {
      data.url <- paste(data.url, id, sep = "$")
    } else if(!is.null(index)){
      if(!is.numeric(index) || index==0){
        stop("index must be integer or not 0")
      }
      index <- paste("[",index, "]", sep = "")
      data.url <- paste(data.url, index, sep = "$")
    } else if(!is.null(key)){
      key <- paste("{",key, "}", sep = "")
      data.url <- paste(data.url, key, sep = "$")
    } else {

    }

    cat("call Bigstreram API -> ",data.url,"\n")
    json <- request(data.url,opt="GET")
    if(flatten) {
      return(jsonlite::fromJSON(json, simplifyVector = TRUE))
    } else {
      return(json)
    }
  }
, env = BS.env)
