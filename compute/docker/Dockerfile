FROM centos:centos7

RUN yum install -y gcc openssh-server openssh-clients epel-release && \
    yum install -y fuse-encfs && \
    chmod 4755 /usr/libexec/openssh/ssh-keysign

ADD ssh_host_ecdsa_key /etc/ssh/ssh_host_ecdsa_key
ADD ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub
ADD ssh_known_hosts /etc/ssh/ssh_known_hosts
ADD ssh_config /etc/ssh/ssh_config
ADD sshd_config /etc/ssh/sshd_config

ADD retrieve_pass /usr/local/bin/retrieve_pass
ADD run.sh /usr/local/bin/run.sh
RUN chmod 700 /usr/local/bin/retrieve_pass /usr/local/bin/run.sh

COPY root_ssh/ /root/.ssh/

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/run.sh"]


