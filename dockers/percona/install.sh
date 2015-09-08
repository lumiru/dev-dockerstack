#!/bin/bash

# =========================================
# Update apt-cache and install softwares
# =========================================

wget -O - http://www.percona.com/redir/downloads/RPM-GPG-KEY-percona | gpg --import
gpg --armor --export 1C4CBDCDCD2EFD2A | apt-key add -
echo "deb http://repo.percona.com/apt "$(lsb_release -sc)" main" > /etc/apt/sources.list.d/percona.list
echo "deb-src http://repo.percona.com/apt "$(lsb_release -sc)" main" >> /etc/apt/sources.list.d/percona.list
echo "percona-server-server-5.6 percona-server-server/root_password password $_mysql_root_password_" | debconf-set-selections
echo "percona-server-server-5.6 percona-server-server/root_password_again password $_mysql_root_password_" | debconf-set-selections

DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -yq --force-yes --no-install-recommends install percona-server-client-5.6 percona-server-server-5.6 && \
    						   apt-get clean && \
    						   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

echo -e "$_mysql_root_password_\nn\ny\ny\ny\ny" > tmp.txt
sudo mysql_secure_installation < tmp.txt
rm tmp.txt
