# bsstat <- function() {
#   statlist<-data.frame()
#   for(name in storage.list()) {
#     tmp = storage.stat(name)
#     statlist <- rbind(as.data.frame(tmp),statlist)
#   }
#   return(statlist)
# }

#new implement
# con <- curl::curl("http://handf.lsr.nectec.or.th:19080/v1/storage/test.mwa.S4/objects?limit=10000&output=stream")
# open(con)
# out <- readLines(con, n = 3) can loop here

#datefilter <- from="2018-01-01",to="2018-03-01"
