#' Get data object from storage
#' @description
#' read data from Bigstream storage via Bigstream storage API
#' This command support on Bigstream version 1.2 or more only
#'
#' @param storage.name storage name
#' @param id Object id
#' @param index get data by index
#' @param key get data by defined key  in storage

#' @return data from Bigstream storage. Return lastest data if no id, index or key param
#'
#' @examples
#' host <- "http://sample.bigstream.io"
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' bs.connect(host, storage_name, token)
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
  function(storage.name,
           id=NULL,index=NULL,key=NULL) {
    if(is.null(bs.active.url))
      stop(bs.no.url)

    # Version 1.2
    data.url <- paste(bs.url, "v1.2/object" ,storage.name, sep = "/")
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
    # version 1.0
    # data.url <- paste(bs.url, "v1/object" ,storage.name, sep = "/")
    # data.url <- paste(data.url, id, sep = ".")
    #
    cat("call Bigstreram API -> ",data.url,"\n")
    json <- request(data.url,opt="GET")
    jsonlite::fromJSON(json, simplifyVector = TRUE)
  }
, env = BS.env)
