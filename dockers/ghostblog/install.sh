#!/bin/bash

# =========================================
# Install Ghost
# =========================================					   
DEBIAN_FRONTEND=noninteractive wget --progress=bar:force -O /root/ghost.zip https://ghost.org/zip/ghost-latest.zip && \
							   mkdir -p /data && \
							   unzip -uo /root/ghost.zip -d /data && \
							   rm -rf /root/ghost.zip && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
							   cp /data/config.example.js /data/config.js && \
							   sed -i "s/url: 'http:\/\/my-ghost-blog.com'/url: 'http:\/\/localhost:2368'/g" /data/config.js && \
							   sed -i "s/host: '127.0.0.1'/host: '0.0.0.0'/g" /data/config.js && \
							   cd /data && \
							   npm install --production
