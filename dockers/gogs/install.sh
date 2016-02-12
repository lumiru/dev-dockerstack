#!/bin/bash

# =========================================
# Update apt-cache and install NodeJS
# =========================================

DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get install -y --no-install-recommends apt-transport-https && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

wget -qO - https://deb.packager.io/key | apt-key add -
echo "deb https://deb.packager.io/gh/pkgr/gogs jessie pkgr" | tee /etc/apt/sources.list.d/gogs.list

DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get install -y --no-install-recommends gogs && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

mkdir /srv/repositories
chown gogs /srv/repositories
