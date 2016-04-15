
FROM centos

COPY slurm_rpm /usr/local/src/
COPY epel.repo /etc/yum.repos.d/epel.repo
COPY RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
COPY munge.key /etc/munge/munge.key

RUN yum --enablerepo=epel install -y fuse-encfs munge /usr/local/src/*.rpm \
    && chown -R root:root /var/log/munge \
    && chown -R root:root /var/lib/munge \
    && mkdir -p /var/run/munge \
    && chown -R root:root /var/run/munge\
    && chown -R root:root /etc/munge \
    && touch /etc/munge/munge.key \
    && chmod 0600 /etc/munge/munge.key \
    && mkdir /mnt/encry1 \
    && mkdir /mnt/encry2 

COPY slurm.conf /etc/slurm/slurm.conf
COPY retrieve_pass /usr/local/bin/retrieve_pass
COPY setup_encfs /usr/local/bin/setup_encfs
COPY run_slurmd /usr/local/bin/run_slurmd

COPY slurmd_ini.sh /usr/local/bin/slurmd_ini.sh
ENTRYPOINT ["/usr/local/bin/slurmd_ini.sh"]
