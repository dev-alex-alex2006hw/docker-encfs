FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -y nfs-common openssh-server inotify-tools -qq

ENV NOTVISIBLE "in users profile"

ADD nfs-client.sh /usr/local/bin/nfs-client
ENTRYPOINT ["/usr/local/bin/nfs-client"]


