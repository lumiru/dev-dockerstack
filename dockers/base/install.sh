#!/bin/bash

# =========================================
# Update apt-cache and install nano, unzip, zip, git, openssh-server
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -y --no-install-recommends install unzip \
							   											  zip \
							   											  nano \
							   											  less \
							   											  wget \
							   											  git \
							   											  sudo \
							   											  update-notifier \
							   											  lsb-release \
							   											  ca-certificates && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


