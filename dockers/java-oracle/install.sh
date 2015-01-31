#!/bin/bash

# ==========================================
# Install repositories
# ==========================================
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

# ==========================================
# Install softwares (Oracle JRE, Oracle JDK)
# ==========================================
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get install -y oracle-java8-installer oracle-java8-set-default && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*