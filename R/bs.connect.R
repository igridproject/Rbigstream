# Bigstream connector

# Create a Bigstream environment
BS.env <- new.env()

local({
  bs.no.url <- "\nNeed to setup Bigstream storage service config first"
  bs.no.storage.pick <- "\nNo select storage"
  bs.v1.path <- "v1/storage"
  bs.v1.1.path <- "v1.1/storage"
  bs.active.url <- NULL
  bs.active.url.v1.1 <- NULL
  bs.url <- NULL
  bs.storage.name <- NULL
  object.path <- "objects"
}, env = BS.env)

#' Setup Bigstream connector function
#'
#' @param host Bigstream Service host.
#' @param port Bigstream API Port (Default : 19080)
#' @param storage_name Set storage name
#' @param token Set API token
#' @return connection setting
#' @examples
#' host <- "http://sample.bigstream.io"
#' port <- 19080
#' storage_name <- "sample.sensordata"
#' token <- "token"
#' conn <- bs.connect(host, port, token)
#' @export
bs.connect <- local(
  function(host,
          port = 19080,
          storage_name = NULL,
          token) {
    old.bs.active.url <- bs.active.url


    if(identical("/",substrRight(host,1))) {
      host <- substrLeft(host,nchar(host)-1)
    }
    bs.active.url <<- paste(host, port, sep = ":")
    bs.url <<- paste(host, port, sep = ":")
    bs.active.url.v1.1 <<- paste(bs.active.url, bs.v1.1.path , sep = "/")
    bs.active.url <<- paste(bs.active.url, bs.v1.path, sep = "/")

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
    }
  }
, env = BS.env)


substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

substrLeft <- function(x, n){
  substr(x, 1, n)
}
