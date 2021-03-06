#' Get data object from storage
#' @description
#' read data from Bigstream storage via Bigstream storage API
#'
#' @param storage.name storage name
#' @param field Specify object output "id","meta" or "data"
#' @param from start from object index default is 1
#' @param offset Lookup data after given object id
#' @param last number of lastest data to read (overwrite "from" arguments)
#' @param limit limit object output
#' @param flatten return flatten Data.frame or return JSON if option is FALSE
#' @return data from Bigstream storage
#'
#' @examples
#' \dontrun{
#' host <- "http://sample.bigstream.io"
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' bs.connect(host, token)
#' storage.read(storage_name)
#' }
#' @export
storage.read <- local(
  function(storage.name,
           field=c("all","data","id","meta","_data","_id","_meta"),
           from = 1,
           offset = NULL,
           last = 0,
           limit = 10,
           flatten = TRUE) {
    if(is.null(bs.active.url))
      stop(bs.no.url)

    field <- match.arg(field)

    data.url <- paste(bs.active.url, storage.name, object.path,sep = "/")
    param.combine <- "limit=10"

    if(!is.numeric(last))
      stop("last must be integer.")

    if(is.null(offset)) {
      param.combine <- add_param(from , offset, limit, last, field)
    } else {
      param.combine <- add_param(NULL , offset, limit, last, field)
    }

    data.url <- paste(data.url, param.combine, sep = "?")

    cat("call Bigstreram API -> ",data.url,"\n")
    json <- request(data.url,opt="GET")
    if(flatten) {
      data.list <- jsonlite::fromJSON(json,simplifyVector = TRUE)
      data.list <- jsonlite::flatten(data.list)
      coln <- sub("^[^\\.]*\\.","",colnames(data.list))
      colnames(data.list) <- coln
      return(data.list)
    } else {
      return(json)
    }
  }
, env = BS.env)


add_param <- function(from, offset, limit, last, field) {
  if(is.null(from))
    param.from <- ""
  else
    param.from <- paste("from",from,sep = "=")
  if(is.null(offset))
    param.offset <- ""
  else
    param.offset <- paste("offset",offset,sep = "=")
  param.limit <- paste("limit",limit,sep = "=")
  if(last==0)
    param.last <- ""
  else
    param.last <- paste("last",last,sep = "=")

  param.field <- paste("field",field,sep = "=")
  param.combine <- paste(param.from, param.offset, param.limit, param.last, param.field,sep = "&")
}
