FROM centos:centos7


RUN yum install -y epel-release && \
    yum install -y fuse-encfs


ADD retrieve_pass /usr/local/bin/retrieve_pass
ADD run.sh /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]


