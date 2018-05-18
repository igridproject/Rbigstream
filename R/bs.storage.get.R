# -------------------------------------------------------------------------------------------
# field param default = all (meta+data)
# from / limit param api example http://handf.lsr.nectec.or.th:19080/v1/storage/test.mwa.S1/objects?from=9&limit=10&field=data
# df <- storage.read(storage_name, field="id|meta|data", from=1, limit=10, by="seq|date|id")

# date refer to written timestamp on bs
# df <- storage.read(storage_name, dateopt="delivery|written", startdate="2018-01-01", enddate="2018-01-31")

#' Get data object from storage
#' @description
#' read data from Bigstream storage via Bigstream storage API
#'
#' @param storage.name storage name
#' @param id Object id

#' @return data from Bigstream storage
#'
#' @examples
#' host <- "http://sample.bigstream.io"
#' port <- 19080
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' conn <- bs.connect(host, port, token)
#' storage.get(storage_name,id="010000000000000258107ea7")
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
