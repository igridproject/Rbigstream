#' Get data object from storage
#' @description
#' read data from Bigstream storage via Bigstream storage API
#' This command support on Bigstream version 1.2 or more only
#'
#' @param storage_name storage name
#' @param id Object id
#' @param index get data by index
#' @param key get data by defined key  in storage
#' @param type file format return default is csv

#' @return url for download object
#'
#' @examples
#' host <- "http://sample.bigstream.io"
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' bs.connect(host, token)
#'
#' #return lastest data as csv
#' url <- storage.getFileUrl(storage_name)
#' read.csv(url, header=FALSE, sep="|")
#'
#' @export
storage.getFileUrl <- local(
  function(storage_name,
           id=NULL,index=NULL,key=NULL,type="dat") {
    if(is.null(bs.active.url))
      stop(bs.no.url)

    # Version 1.2
    #type <- match.arg(type)
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
    token <- paste("token",bs.token, sep="=")
    data.url <- paste(data.url, "data", sep = "/")
    data.url <- paste(data.url, "filetype", sep = "?")
    data.url <- paste(data.url, type, sep = "=")
    data.url <- paste(data.url, token, sep = "&")
    cat("return Bigstreram data url -> ",data.url,"\n")
    return(data.url)
    # json <- request(data.url,opt="GET")
    # if(flatten) {
    #   return(jsonlite::fromJSON(json, simplifyVector = TRUE))
    # } else {
    #   return(json)
    # }
  }
, env = BS.env)
