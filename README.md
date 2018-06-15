# Rbigstream
BigStream Control ,Storage and Virtual Repository Interface for R
[updated 2018-06-15]


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
?storage.stat
```
## Example Code

```{r}
library(Rbigstream)

host = "http://<bigstream.storage-api.url>"
storage_name = "storage.name"
token = "--authentication token--"

conn1 <- bs.connect(host, storage_name, token)

storage.list()                     # list all storages of default connection
storage.list(conn = conn1)         # list all storages of given connection

stat <- storage.stat(storage_name) # count number of data in a particular storage ; named list data type
stat$count
stat$filesize


# field param default = data (meta+data) : field=c("data","id","meta","_data","_id","_meta")
# from / limit param api example
df <- storage.read(storage_name, field="data", from=9, limit=10)
df <- storage.read(storage_name, field="id", offset="010000000000000258107ea7", limit=10)
df <- storage.read(storage_name, field="meta", last=10)
df <- storage.read(storage_name, field="data", last=10, limit=10)

# return value as json 
df <- storage.read(storage_name, field="data", last=10, limit=10, flatten=FALSE)

# get single object data
list1 <- storage.get(storage_name)  # return lastest data of given storage

# return data object 010000000000000258107ea7
list1 <- storage.get(storage_name,id="010000000000000258107ea7")

# return data index 1 (1st data in storage)
list1 <- storage.get(storage_name,index=1)

# return data by key defined ("_key":value search  )
list1 <- storage.get(storage_name,key="")

# append need api version 1.2 or above
storage.put(storage_name = "test.api", df)

# same as storage.put but remove existing data on storage out first
storage.save(storage_name = "test.api", df)

```
