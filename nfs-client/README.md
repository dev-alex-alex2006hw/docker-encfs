Docker NFS Server
================

Usage
----
```
server:
docker build -t nfs-server .
docker run -d --name nfs --cap-add SYS_ADMIN nfs-server /path/to/share /path/to/share2 /path/to/shareN
docker exec -it nfs /bin/bash

client:
docker build -t nfs-client .
docker run -d --name nfs-client --cap-add SYS_ADMIN --link nfs:nfs nfs-client /path/on/nfs/server:/path/on/client
docker exec -it nfs-client /bin/bash

``` 

