#!/bin/bash

# =========================================
# Update apt-cache and install softwares (Jetty)
# =========================================
DEBIAN_FRONTEND=noninteractive wget --progress=bar:force -O /root/jetty-hightide-server.deb $JETTY_URL && \
							   dpkg -i /root/jetty-hightide-server.deb && \
                               apt-get -yq --force-yes --no-install-recommends install -f && \
    						   apt-get clean && \
    						   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Jetty servers and contexts in /srv/jetty

# Local folders
mkdir -p /srv/jetty/contexts
mkdir -p /srv/jetty/logs
mkdir -p /srv/jetty/webapps

# Update configuration
sed -i 's,<Property name="jetty.home" default="." />,/srv/jetty,' /opt/jetty/etc/jetty-contexts.xml
sed -i 's,<Property name="jetty.logs" default="./logs"/>,/srv/jetty/logs/,' /opt/jetty/etc/jetty-logging.xml
sed -i 's,<Property name="jetty.home" default="." />/webapps,/srv/jetty/webapps,' /opt/jetty/etc/jetty-webapps.xml
sed -i 's,<Property name="jetty.home" default="." />/contexts,/srv/jetty/contexts,' /opt/jetty/etc/jetty-webapps.xml