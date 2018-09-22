#!/bin/bash

# Add repository
cat <<EOF >>/etc/yum.repos.d/devtools.repo
[rhscl-rpms]
metadata_expire = 86400
baseurl = https://pulp.dist.prod.ext.phx2.redhat.com/content/dist/rhel/server/7/7Server/\$basearch/rhscl/1/os
ui_repoid_vars = releasever basearch
sslverify = 0
name = Red Hat Scl (RPMs)
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
enabled = 1
sslcacert = /etc/rhsm/ca/redhat-uep.pem
gpgcheck = 1
[devtools-rpms]
metadata_expire = 86400
baseurl = https://pulp.dist.prod.ext.phx2.redhat.com/content/dist/rhel/server/7/7Server/\$basearch/devtools/1/os
ui_repoid_vars = releasever basearch
sslverify = 0
name = Red Hat DevTools (RPMs)
gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
enabled = 1
sslcacert = /etc/rhsm/ca/redhat-uep.pem
gpgcheck = 1
EOF

# Install dependecies
yum install -y svn git patch llvm-toolset-7 llvm-private-devel autoconf libtool pcre-devel libxml2-devel pcre-static

# Enable software collection
. scl_source enable llvm-toolset-7

# Run preparations scripts with enabled software collection
./scripts/prepare_afl.sh /tmp
./scripts/install_afl.sh /tmp
./scripts/prepare_apache.sh /tmp
