#!/bin/bash

# =========================================
# Update apt-cache and install softwares
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -yq --force-yes --no-install-recommends install memcached && \
    						   apt-get clean && \
    						   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
