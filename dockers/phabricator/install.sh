#!/bin/bash

# =========================================
# Update apt-cache and install Phabricator
# =========================================
DEBIAN_FRONTEND=noninteractive git clone https://github.com/phacility/libphutil.git /var/www/html/libphutil && \
							   git clone https://github.com/phacility/arcanist.git /var/www/html/arcanist && \
							   git clone https://github.com/phacility/phabricator.git /var/www/html/phabricator

# =========================================
# Install SVNServer
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get install -y --no-install-recommends subversion \
																		  mercurial && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
