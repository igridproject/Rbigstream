# Bigstream connector

# Create a Bigstream environment
BS.env <- new.env()

local({
  bs.no.url <- "\nNeed to setup Bigstream storage service config first"
  bs.no.storage.pick <- "\nNo select storage"
  bs.path <- "storage"
  bs.token <- NULL
  bs.active.url <- NULL
  bs.url <- NULL
  bs.storage.name <- NULL
  port <- 19080
  object.path <- "objects"

  # wrapper for httr get call
  request <- function(data.url,body = NULL,opt=c("GET","PUT","DELETE")){
    opt <- match.arg(opt)

    if(opt=="GET"){
      if(!RCurl::url.exists(data.url))
        stop("Cannot connnect to Bigstream via ", data.url," or Bigstream server version does not support.")
      req <- httr::GET(data.url,httr::add_headers(.headers =c("Authorization"=paste("Bearer",bs.token,sep=" "))))
    } else if(opt=="DELETE") {
      req <- httr::DELETE(data.url,httr::add_headers(.headers =c("Authorization"=paste("Bearer",bs.token,sep=" "))))
    } else if(opt=="PUT") {
      if(is.null(body)) stop("call opt = put must have body param")
      req <- httr::PUT(data.url,body=body,httr::add_headers(.headers =c("Content-Type"="application/json","User-Agent"="Rbigstream","Authorization"=paste("Bearer",bs.token,sep=" "))))
    }
    if(httr::status_code(req)==403 || httr::status_code(req)==401)
      stop("Your token is invalid. Try call bs.connect with Authorization token again.")
    json <- httr::content(req,"text",encoding = "utf8")
    return(json)
  }
}, env = BS.env)

#' Setup Bigstream connector function
#'
#' @param host Bigstream Service host.
#' @param storage_name Set storage name
#' @param token Set API token
#' @return connection setting
#' @examples
#' host <- "http://sample.bigstream.io/"
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' bs.connect(host, storage_name, token)
#' @export
bs.connect <- local(
  function(host,
          storage_name = NULL,
          token
          ) {
    old.bs.active.url <- bs.active.url


    if(identical("/",substrRight(host,1))) {
      host <- substrLeft(host,nchar(host)-1)
    }

    #Set up token
    bs.token <<- token

    # root path
    bs.url <<- bs.active.url
    bs.active.url <<- paste(host, bs.path, sep = "/")

    if(!(is.null(storage_name)))
      bs.storage.name <<- storage_name
    cat("Set up Bigstream host to ")
    cat(bs.active.url,fill = TRUE)
    return(bs.active.url)
}
, env = BS.env)

#' Get current Bigstream connection setting
#' @return Show store connection setting
#' @examples
#' bs
#' @export
bs <- local(
  function() {
    if(is.null(bs.active.url)  ) {
      cat(bs.no.url)
    }
    else {
      cat("\nCurrent Bigstream host : ")
      cat(bs.active.url)
      if(is.null(bs.storage.name)){
        cat(bs.no.storage.pick)
      }
      else {
        cat("\nCurrent Storage : ")
        cat(bs.storage.name)
      }
      cat("\ntoken : ",bs.token)
    }
  }
, env = BS.env)


substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

substrLeft <- function(x, n){
  substr(x, 1, n)
}
