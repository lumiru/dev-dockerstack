#!/bin/bash

# =========================================
# Configure sources.list
# =========================================
echo "
# ==> Main repository
deb http://archive.ubuntu.com/ubuntu trusty main restricted universe
# ==> Update repository
deb http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe
# ==> Proposed repository
deb http://archive.ubuntu.com/ubuntu/ trusty-proposed main restricted universe
# ==> Backports repository 
deb http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe
# ==> Security repository 
deb http://security.ubuntu.com/ubuntu trusty-security main restricted universe
# ==> Partner repository 
deb http://archive.canonical.com/ubuntu trusty partner" > /etc/apt/sources.list

# =========================================
# Update apt-cache and install nano, unzip, zip, git, openssh-server
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -y --no-install-recommends install nano \
							   											  unzip \
							   											  zip \
							   											  git \
							   											  wget \
							   											  ca-certificates \
							   											  openssh-server && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

