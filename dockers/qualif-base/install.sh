#!/bin/bash

# ================================================
# Update apt-cache and install minimal requirments
# ================================================
DEBIAN_FRONTEND=noninteractive wget -O - https://deb.nodesource.com/setup_4.x | bash -

DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -y --no-install-recommends install mysql-client openssh-server rsync drush nodejs && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

sed -ri 's/#force_color_prompt=yes/force_color_prompt=yes/g' /etc/skel/.bashrc
