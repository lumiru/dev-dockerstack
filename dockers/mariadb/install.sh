#!/bin/bash

PASS='root'

# =========================================
# Update apt-cache and install software (MariaDB-Server)
# =========================================
DEBIAN_FRONTEND=noninteractive debconf-set-selections <<< "mariadb-server-10.0 mysql-server/root_password password $PASS" && \
							   debconf-set-selections <<< "mariadb-server-10.0 mysql-server/root_password_again password $PASS" && \
							   apt-get update && \
							   apt-get -yq --force-yes --no-install-recommends install mariadb-server && \
       						   apt-get clean && \
    						   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
