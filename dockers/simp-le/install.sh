#!/bin/bash

# =========================================
# Update apt-cache and install NodeJS
# =========================================

export DEBIAN_FRONTEND=noninteractive
cd /opt
wget https://github.com/kuba/simp_le/archive/master.zip
unzip master.zip
mv simp_le-master simp_le
#git clone https://github.com/kuba/simp_le
cd simp_le
./bootstrap.sh
./venv.sh
ln -s $(pwd)/venv/bin/simp_le /usr/local/sbin/simp_le
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
