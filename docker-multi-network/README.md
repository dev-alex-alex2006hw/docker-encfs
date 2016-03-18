```
docker attach shell1
ping web
ctl+pq to exit

docker exec -it web /bin/bash
ping shell1

##containers know each other !

chu@chu-Precision-T1700:~/data/docker-encry$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
519bc0d3d657        alpine              "/bin/sh"                40 minutes ago      Up 33 minutes                           c0-n2/shell1
a2b7bdc2d332        nginx               "nginx -g 'daemon off"   40 minutes ago      Up 35 minutes       80/tcp, 443/tcp     c0-n1/web

chu@chu-Precision-T1700:~/data/docker-encry$ docker-machine ssh c0-n1
                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/
 _                 _   ____     _            _
| |__   ___   ___ | |_|___ \ __| | ___   ___| | _____ _ __
| '_ \ / _ \ / _ \| __| __) / _` |/ _ \ / __| |/ / _ \ '__|
| |_) | (_) | (_) | |_ / __/ (_| | (_) | (__|   <  __/ |
|_.__/ \___/ \___/ \__|_____\__,_|\___/ \___|_|\_\___|_|
Boot2Docker version 1.10.3, build master : 625117e - Thu Mar 10 22:09:02 UTC 2016
Docker version 1.10.3, build 20f81dd
docker@c0-n1:~$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
a2b7bdc2d332        nginx               "nginx -g 'daemon off"   21 minutes ago      Up 16 minutes       80/tcp, 443/tcp     web
7491307dc63b        swarm:latest        "/swarm join --advert"   26 minutes ago      Up 26 minutes                           swarm-agent

chu@chu-Precision-T1700:~/data/docker-encry$ docker-machine ssh c0-n2
                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/
 _                 _   ____     _            _
| |__   ___   ___ | |_|___ \ __| | ___   ___| | _____ _ __
| '_ \ / _ \ / _ \| __| __) / _` |/ _ \ / __| |/ / _ \ '__|
| |_) | (_) | (_) | |_ / __/ (_| | (_) | (__|   <  __/ |
|_.__/ \___/ \___/ \__|_____\__,_|\___/ \___|_|\_\___|_|
Boot2Docker version 1.10.3, build master : 625117e - Thu Mar 10 22:09:02 UTC 2016
Docker version 1.10.3, build 20f81dd
docker@c0-n2:~$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
519bc0d3d657        alpine              "/bin/sh"                20 minutes ago      Up 13 minutes                           shell1
84a51d79e013        swarm:latest        "/swarm join --advert"   24 minutes ago      Up 24 minutes                           swarm-agent
```
