#!/bin/bash

# =======================================
# Add MongoDB Repository
# =======================================
DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
	echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list

# =======================================
# Update apt-cache and install MongoDB
# =======================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -yq --force-yes --no-install-recommends install mongodb-org && \
							   sed 's/^bind_ip/#bind_ip/' -i /etc/mongod.conf && \
							   sed 's/^#httpinterface/httpinterface/' -i /etc/mongod.conf && \
							   sed 's/^#port/port/' -i /etc/mongod.conf && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# MongoDB configuration file
# /etc/mongod.conf

# Directory for MongoDB
# Sources: /usr/bin/
# Logs: /var/log/mongodb/mongod.log
# Data: /var/opt/mongodb/

# Port to use MongoDB
# 27017 : The default port for mongod and mongos instances
# 28017 : The default port for the web status page

DEBIAN_FRONTEND=noninteractive mkdir -p /var/opt/mongodb
