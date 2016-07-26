FROM centos:centos7

COPY torque-6.0.1-1.adaptive.el7.centos.x86_64.rpm /usr/local/src/torque-6.0.1-1.adaptive.el7.centos.x86_64.rpm

RUN yum install -y gcc openssh-server openssh-clients epel-release && \
    yum install -y fuse-encfs /usr/local/src/torque-6.0.1-1.adaptive.el7.centos.x86_64.rpm && \
    chmod 4755 /usr/libexec/openssh/ssh-keysign

COPY server_name /var/spool/torque/server_name
COPY ssh_host_ecdsa_key /etc/ssh/ssh_host_ecdsa_key
COPY ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub

COPY sshd_config /etc/ssh/sshd_config
COPY ssh_config /etc/ssh/ssh_config
COPY ssh_known_hosts /etc/ssh/ssh_known_hosts
COPY shosts.equiv /etc/ssh/shosts.equiv

ADD retrieve_pass /usr/local/bin/retrieve_pass
ADD run.sh /usr/local/bin/run.sh
RUN chmod 700 /usr/local/bin/retrieve_pass /usr/local/bin/run.sh

COPY root_ssh/ /root/.ssh/

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/run.sh"]


