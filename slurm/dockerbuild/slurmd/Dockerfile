
FROM centos

COPY slurm_rpm /usr/local/src/
RUN yum install -y /usr/local/src/*.rpm

COPY munge.key /etc/munge/munge.key
RUN chown -R root:root /var/log/munge \
    && chown -R root:root /var/lib/munge \
    && mkdir -p /var/run/munge \
    && chown -R root:root /var/run/munge\
    && chown -R root:root /etc/munge \
    && chmod 0600 /etc/munge/munge.key

COPY slurm.conf /etc/slurm/slurm.conf

COPY slurmd_ini.sh /usr/local/bin/slurmd_ini.sh
ENTRYPOINT ["/usr/local/bin/slurmd_ini.sh"]
