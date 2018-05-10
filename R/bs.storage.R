# -------------------------------------------------------------------------------------------
# list all storages of default connection / given connection.

#' @export
storage.list <- local(
  function(conn = NULL) {
    url <- ""
    if(!is.null(conn))
      url <- conn
    else {
      if(is.null(bs.active.url))
        stop(bs.no.url)
      url <- bs.active.url
    }
    if(!RCurl::url.exists(url))
      stop("Cannot connnect to Bigstream via ", url)
    cat("call Bigstreram API -> ",url,"\n")
    jsonlite::read_json(url,simplifyVector = TRUE)
  }
, env = BS.env)

# -------------------------------------------------------------------------------------------
# count number of data in a particular storage.
# stat <- storage.stat(storage_name)
# stat$count
# stat$size

#' @export
storage.stat <- local(
  function(storage_name) {
    if(is.null(bs.active.url))
      stop(bs.no.url)
    bs.active.url <- paste(bs.active.url, storage_name, "stats",sep = "/")
    if(!RCurl::url.exists(bs.active.url))
      stop("Cannot connnect to Bigstream via ", url)
    jsonlite::read_json(bs.active.url,simplifyVector = TRUE)
  }
, env = BS.env)

# -------------------------------------------------------------------------------------------
# field param default = all (meta+data)
# from / limit param api example http://handf.lsr.nectec.or.th:19080/v1/storage/test.mwa.S1/objects?from=9&limit=10&field=data
# df <- storage.read(storage_name, field="id|meta|data", from=1, limit=10, by="seq|date|id")

# date refer to written timestamp on bs
# df <- storage.read(storage_name, dateopt="delivery|written", startdate="2018-01-01", enddate="2018-01-31")

#' @export
storage.read <- local(
  function(storage.name,
           field=c("data","id","meta"),
           from = 1,
           offset = NULL,
           last = 0,
           limit = 10,
           date_opt = NULL) {
    if(is.null(bs.active.url))
      stop(bs.no.url)

    field <- match.arg(field)

    data.url <- paste(bs.active.url, storage.name, object.path,sep = "/")
    param.combine <- "limit=10"

    if(!is.numeric(last) || !is.numeric(limit))
      stop("last or limit param must be integer.")

    if(is.null(offset)) {
      param.combine <- add_param(from , offset, limit, last, field)
    } else {
      param.combine <- add_param(NULL , offset, limit, last, field)
    }

    data.url <- paste(data.url, param.combine, sep = "?")
    if(!RCurl::url.exists(data.url))
      stop("Cannot connnect to Bigstream via ", data.url)
    cat("call Bigstreram API -> ",data.url,"\n")
    data.list <- jsonlite::read_json(data.url, simplifyVector = TRUE)
    stopifnot(is.data.frame(data.list))
    jsonlite::flatten(data.list)
  }
, env = BS.env)

#' @export
storage.get <- local(
  function(storage.name,
           id) {
    if(is.null(bs.active.url))
      stop(bs.no.url)

    data.url <- paste(bs.url, "v1/object" ,storage.name, sep = "/")
    data.url <- paste(data.url, id, sep = ".")

    if(!RCurl::url.exists(data.url))
      stop("Cannot connnect to Bigstream via ", data.url)
    cat("call Bigstreram API -> ",data.url,"\n")
    data.list <- jsonlite::read_json(data.url, simplifyVector = TRUE)
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

# bsstat <- function() { statlist<-data.frame() ;for(name in storage.list()) { tmp = storage.stat(name) ; statlist <- rbind(as.data.frame(tmp),statlist)} ; statlist[order(statlist[,1])] }

#new implement
# con <- curl::curl("http://handf.lsr.nectec.or.th:19080/v1/storage/test.mwa.S4/objects?limit=10000&output=stream")
# open(con)
# out <- readLines(con, n = 3) can loop here

#datefilter <- from="2018-01-01",to="2018-03-01"
