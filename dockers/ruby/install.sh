#!/bin/bash

# =========================================
# Update apt-cache and install ruby
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get install -yq --force-yes --no-install-recommends ruby \
							   														   ruby-dev \
							   														   ruby-bundler && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*