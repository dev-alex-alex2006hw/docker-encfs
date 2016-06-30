FROM centos:centos7

RUN yum install -y openssh-server openssh-clients epel-release && \
    yum install -y fuse-encfs 

COPY sshd_config /etc/ssh/sshd_config

COPY ssh_host_ecdsa_key /etc/ssh/ssh_host_ecdsa_key
COPY ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub
COPY ssh_host_ed25519_key /etc/ssh/ssh_host_ed25519_key
COPY ssh_host_ed25519_key.pub /etc/ssh/ssh_host_ed25519_key.pub

COPY ssh_known_hosts /etc/ssh/ssh_known_hosts
COPY shosts.equiv /etc/ssh/shosts.equiv

ADD retrieve_pass /usr/local/bin/retrieve_pass
ADD compute.sh /usr/local/bin/compute

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/compute"]


