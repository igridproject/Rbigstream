# Bigstream connector

# Create a Bigstream environment
BS.env <- new.env()

local({
  bs.no.url <- "\nNeed to setup Bigstream storage service config first"
  bs.no.storage.pick <- "\nNo select storage"
  bs.active.url <- NULL
  bs.url <- NULL
  bs.storage.name <- NULL
  object.path <- "objects"
}, env = BS.env)

#' @export
bs.connect <- local(
  function(host,
          port = 19080,
          storage_name = NULL,
          token) {
    old.bs.active.url <- bs.active.url

    bs.path <- "v1/storage"
    if(identical("/",substrRight(host,1))) {
      host <- substrLeft(host,nchar(host)-1)
    }
    bs.active.url <<- paste(host, port, sep = ":")
    bs.url <<- paste(host, port, sep = ":")
    bs.active.url <<- paste(bs.active.url, bs.path, sep = "/")
    if(!(is.null(storage_name)))
      bs.storage.name <<- storage_name
    cat("Set up Bigstream host to ")
    cat(bs.active.url,fill = TRUE)
    return(bs.active.url)
}
, env = BS.env)

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
