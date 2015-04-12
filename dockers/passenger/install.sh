#!/bin/bash

# =========================================
# Install software dependancies
# =========================================

DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get install -y git git-core libcurl4-openssl-dev curl procps && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# =========================================
# Install RVM
# =========================================

gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
curl -L https://get.rvm.io | bash -s stable --ruby=2.1

source /usr/local/rvm/scripts/rvm
echo '[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"' >> ~/.bashrc

# =========================================
# Install passenger (CGI interface)
# =========================================

gem install passenger bundler --no-ri --no-rdoc
passenger-install-nginx-module
