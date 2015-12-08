#!/bin/bash

# =========================================
# Update apt-cache and install CouchDB
# build tools and dependancies
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -y --no-install-recommends install build-essential \
																		  erlang-base-hipe \
																		  erlang-dev \
																		  erlang-manpages \
																		  erlang-eunit \
																		  erlang-nox \
																		  libicu-dev \
																		  libmozjs185-dev \
																		  libcurl4-openssl-dev && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# =========================================
# Installing CouchDB
# =========================================

wget $COUCHDB_TARBALL_URL
tar -xvf apache-couchdb-*.tar.gz
./configure
make
make install
adduser --no-create-home couchdb
chown -R couchdb:couchdb /usr/local/var/lib/couchdb/ /usr/local/var/log/couchdb/ /usr/local/var/run/couchdb/
ln -s /usr/local/etc/init.d/couchdb /etc/init.d/couchdb
update-rc.d couchdb defaults
sed -i "s,port = ,port = 80 ;," /usr/local/etc/couchdb/local.ini
sed -i "s,bind_address = ,bind_address = 0.0.0.0," /usr/local/etc/couchdb/local.ini

# =========================================
# Start CouchDB
# =========================================
# /usr/local/bin/couchdb