#!/bin/bash

# =========================================
# Install MailDev
# =========================================
DEBIAN_FRONTEND=noninteractive npm install -g maildev && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
