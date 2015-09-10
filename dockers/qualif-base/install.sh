#!/bin/bash

# =========================================
# Update apt-cache and install Apache2
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -y --no-install-recommends install mysql-client openssh-server && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
