#!/bin/bash

version=15.08.9
wget http://www.schedmd.com/download/latest/slurm-$version.tar.bz2
yum install -y  gcc gcc-c++ mailx make munge munge-devel munge-libs openssl openssl-devel pam-devel perl perl-ExtUtils-MakeMaker readline-devel rpm-build mysql-devel
# openmpi will depend on slurm pmi header, so install slurm first and then openmpi
# mysql-devel is needed for slurm database plugin

## customize rpm marcro
# build options      .rpmmacros options      change to default action
# ===============    ====================    ========================
# --enable-multiple-slurmd %_with_multiple_slurmd 1  build with the multiple slurmd
#                                               option.  Typically used to simulate a
#                                               larger system than one has access to.
# --enable-salloc-background %_with_salloc_background 1  on a cray system alloc salloc
#                                               to execute as a background process.
# --prefix           %_prefix             path  install path for commands, libraries, etc.
# --with auth_none   %_with_auth_none     1     build auth-none RPM
# --with blcr        %_with_blcr          1     require blcr support
# --without debug    %_without_debug      1     don't compile with debugging symbols
# --with pmix        %_with_pmix          1     build pmix support
# --with lua         %_with_lua           1     build Slurm lua bindings (proctrack only for now)
# --without munge    %_without_munge      path  don't build auth-munge RPM
# --with mysql       %_with_mysql         1     require mysql/mariadb support
# --without netloc   %_without_netloc     path  require netloc support
# --with openssl     %_with_openssl       1     require openssl RPM to be installed
# --without pam      %_without_pam        1     don't require pam-devel RPM to be installed
# --with percs       %_with_percs         1     build percs RPM
# --without readline %_without_readline   1     don't require readline-devel RPM to be installed

slurm_prefix=/opt/slurm/$version

echo %_prefix $slurm_prefix > ~/.rpmmacros
rpmbuild -ta slurm-$version.tar.bz2

yum install -y ~/rpmbuild/RPMS/x86_64/slurm*.rpm
# still need to sync to nodes
# grep -v /opt $(rpm -qlp slurm*.rpm) | sort
# /etc/init.d/slurm
# /etc/init.d/slurmdbd
# /etc/ld.so.conf.d
# /etc/ld.so.conf.d/slurm.conf
# /etc/slurm
# /etc/slurm/cgroup_allowed_devices_file.conf.example
# /etc/slurm/cgroup.conf.example
# /etc/slurm/cgroup.release_common.example
# /etc/slurm/cgroup/release_cpuset
# /etc/slurm/cgroup/release_freezer
# /etc/slurm/cgroup/release_memory
# /etc/slurm/layouts.d.power.conf.example
# /etc/slurm/layouts.d.power_cpufreq.conf.example
# /etc/slurm/slurm.conf.example
# /etc/slurm/slurmdbd.conf.example
# /etc/slurm/slurm.epilog.clean
# /lib64/security/pam_slurm_adopt.so
# /lib64/security/pam_slurm.so
# /usr/lib/systemd/system/slurmctld.service
# /usr/lib/systemd/system/slurmdbd.service
# /usr/lib/systemd/system/slurmd.service
# /usr/sbin/rcslurm
# /usr/sbin/rcslurmdbd


cat > /etc/profile.d/slurm.sh <<EOF
#!/bin/sh
export PATH=$slurm_prefix/bin:$slurm_prefix/sbin:$PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
 export LD_LIBRARY_PATH=:
fi
export LD_LIBRARY_PATH=$slurm_prefix/lib:$LD_LIBRARY_PATH

if [ -z "$MANPATH" ] ; then
 export MANPATH=:
fi
export MANPATH=$slurm_prefix/share/man:$MANPATH
EOF

chmod +x /etc/profile.d/slurm.sh  # need to sync to nodes

useradd -r slurm  # create system user, no home, no-login


