#!/bin/bash

# =========================================
# Update apt-cache and install software (MariaDB-Server)
# =========================================
DEBIAN_FRONTEND=noninteractive echo "deb http://ftp.igh.cnrs.fr/pub/mariadb/repo/10.0/ubuntu trusty main" >> /etc/apt/sources.list && \
							   apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db && \
							   apt-get update && \
							   apt-get -yq --force-yes --no-install-recommends install mariadb-server && \
       						   apt-get clean && \
    						   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*