
FROM centos

COPY slurm_rpm /usr/local/src/
COPY epel.repo /etc/yum.repos.d/epel.repo
COPY RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

RUN yum install -y munge /usr/local/src/*.rpm 
    && chown -R root:root /var/log/munge \
    && chown -R root:root /var/lib/munge \
    && mkdir -p /var/run/munge \
    && chown -R root:root /var/run/munge\
    && chown -R root:root /etc/munge \
    && touch /etc/munge/munge.key \
    && chmod 0600 /etc/munge/munge.key 

COPY munge.key /etc/munge/munge.key
COPY slurm.conf /etc/slurm/slurm.conf

COPY slurmctld_ini.sh /usr/local/bin/slurmctld_ini.sh
ENTRYPOINT ["/usr/local/bin/slurmctld_ini.sh"]
