#!/bin/bash

# =========================================
# Update apt-cache and install NodeJS
# =========================================					   
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get install -y --no-install-recommends haproxy && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
