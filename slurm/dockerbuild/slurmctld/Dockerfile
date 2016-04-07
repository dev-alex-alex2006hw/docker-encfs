
FROM centos

COPY slurm_rpm /usr/local/src/

RUN yum install -y epel-release
RUN yum install -y munge
RUN yum install -y /usr/local/src/*.rpm