FROM centos:centos7


RUN yum install -y gcc openssh-server openssh-clients epel-release && \
    yum install -y fuse-encfs && \
    chmod 4755 /usr/libexec/openssh/ssh-keysign

ADD retrieve_pass /usr/local/bin/retrieve_pass
ADD run.sh /usr/local/bin/run.sh

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/run.sh"]


