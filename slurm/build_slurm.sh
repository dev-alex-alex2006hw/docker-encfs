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

rpmbuild -ta slurm-$version.tar.bz2
