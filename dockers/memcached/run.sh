#!/bin/bash

# =========================================
# Generate password (for production)
# =========================================
# $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

# =========================================
# Launch Memcached
# =========================================
echo "=> Launch Memcached with parameters :
MEMCACHED_IP = $MEMCACHED_IP
MEMCACHED_SIZE = $MEMCACHED_SIZE
MEMCACHED_CONCURENT = $MEMCACHED_CONCURENT
MEMCACHED_THREAD = $MEMCACHED_THREAD"

/usr/bin/memcached -u root \
				   -l $MEMCACHED_IP \
				   -m $MEMCACHED_SIZE \
				   -c $MEMCACHED_CONCURENT \
				   -t $MEMCACHED_THREAD \
				   -v
# If I want use Authentification for Memcached (later)
# -S <= Active SASL
#/usr/bin/memcached -S
