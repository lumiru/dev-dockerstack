#!/bin/bash

# =========================================
# Update apt-cache and install NodeJS
# =========================================					   
DEBIAN_FRONTEND=noninteractive wget -O - https://deb.nodesource.com/setup_4.x  | bash - && \
							   apt-get update && \
							   apt-get install -y --no-install-recommends nodejs && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
