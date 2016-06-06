#!/bin/bash

# =========================================
# Update apt-cache and install softwares (automysqlbackup)
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update &&
                                                   apt-get -yq --force-yes install automysqlbackup && \
                                                   apt-get clean && \
                                                   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
mkdir -p /srv/etc/
mv /etc/default/automysqlbackup /srv/etc/
ln -s /srv/etc/automysqlbackup /etc/default/
