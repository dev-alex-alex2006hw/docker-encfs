
FROM centos

COPY slurm_rpm /usr/local/src/
RUN yum install -y /usr/local/src/*.rpm fuse-encfs

COPY munge.key /etc/munge/munge.key
RUN chown -R root:root /var/log/munge \
    && chown -R root:root /var/lib/munge \
    && mkdir -p /var/run/munge \
    && chown -R root:root /var/run/munge\
    && chown -R root:root /etc/munge \
    && chmod 0600 /etc/munge/munge.key \
    && mkdir /mnt/encry1 \
    && mkdir /mnt/encry2

COPY slurm.conf /etc/slurm/slurm.conf
COPY retrieve_pass /usr/local/bin/retrieve_pass
COPY setup_encfs /usr/local/bin/setup_encfs

COPY slurmd_ini.sh /usr/local/bin/slurmd_ini.sh
ENTRYPOINT ["/usr/local/bin/slurmd_ini.sh"]
