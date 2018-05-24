# Rbigstream
BigStream Control ,Storage and Virtual Repository Interface for R
[updated 2018-05-24]


## Package installation


* install devtools 
```{r}
install.packages("devtools")
```

* install lastest version Rbigstream from github
```{r}
devtools::install_github("igridproject/Rbigstream")
```

## Function Help
```{r}
library(Rbigstream)
?bs.connect
?storage.list
?storage.get
?storage.read
?storage.put
```
## Example Code

```{r}
library(Rbigstream)

host = "http://<bigstream.storage-api.url>"
port = 19080
storage_name = "storage.name"
token = "--authentication token--"

conn1 <- bs.connect(host, port, token)

storage.list()                     # list all storages of default connection
storage.list(conn = conn1)         # list all storages of given connection

stat <- storage.stat(storage_name) # count number of data in a particular storage ; named list data type
stat$count
stat$filesize

# field param default = all (meta+data)
# from / limit param api example
df <- storage.read(storage_name, field="data", from=9, limit=10)

df <- storage.read(storage_name, field="id", offset="010000000000000258107ea7", limit=10)

# datefilter is refer to field "_id"  field="id|meta|data"
df <- storage.read(storage_name, field="id", filter=datefilter(from="2018-01-01",to="2018-03-01") )

df <- storage.read(storage_name, field="meta", last=10)
df <- storage.read(storage_name, field="data", last=10, limit=10)


# date refer to written timestamp on bs
list1 <- storage.get(storage_name, id="010000000000000258107ea7") # named list

# append need api version 1.1 or above
storage.put(storage_name = "test.api", df)
```
