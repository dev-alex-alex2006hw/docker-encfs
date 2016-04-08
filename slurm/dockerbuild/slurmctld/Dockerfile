
FROM centos

COPY slurm_rpm /usr/local/src/

RUN yum install -y epel-release

RUN yum install -y munge
COPY munge.key /etc/munge/munge.key
RUN chown -R root:root /var/log/munge
RUN chown -R root:root /var/lib/munge
RUN mkdir -p /var/run/munge
RUN chown -R root:root /var/run/munge
RUN chown -R root:root /etc/munge

RUN yum install -y /usr/local/src/*.rpm
