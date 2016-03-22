FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -y nfs-common openssh-server torque-mom torque-client inotify-tools -qq

ENV NOTVISIBLE "in users profile"

COPY sshd_config /etc/ssh/sshd_config

COPY ssh_host_ecdsa_key /etc/ssh/ssh_host_ecdsa_key
COPY ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub
COPY ssh_host_ed25519_key /etc/ssh/ssh_host_ed25519_key
COPY ssh_host_ed25519_key.pub /etc/ssh/ssh_host_ed25519_key.pub

COPY ssh_known_hosts /etc/ssh/ssh_known_hosts
COPY shosts.equiv /etc/ssh/shosts.equiv

ADD pbs_client_setup.sh /usr/local/bin/pbs_client_setup
ENTRYPOINT ["/usr/local/bin/pbs_client_setup"]


