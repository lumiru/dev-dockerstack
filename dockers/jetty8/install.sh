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
sed -i 's,# --exec,--exec,' /opt/jetty/start.ini
# sed -i 's,# -Xmx2000m,-Xmx8G,' /opt/jetty/start.ini
sed -i 's,# etc/jetty-requestlog.xml,etc/jetty-requestlog.xml,' /opt/jetty/start.ini
sed -i 's,etc/jetty-testrealm.xml,#etc/jetty-testrealm.xml,' /opt/jetty/start.ini
sed -i 's,etc/jetty-jaas.xml,#etc/jetty-jaas.xml,' /opt/jetty/start.ini
sed -i 's,"sendServerVersion">true,"sendServerVersion">false,' /opt/jetty/etc/jetty.xml
sed -i 's,<Property name="jetty.home" default="." />,/srv/jetty,' /opt/jetty/etc/jetty-contexts.xml
sed -i 's,<Property name="jetty.logs" default="./logs"/>,/srv/jetty/logs/,' /opt/jetty/etc/jetty-logging.xml
sed -i 's,<Property name="jetty.logs" default="./logs"/>,/srv/jetty/logs/,' /opt/jetty/etc/jetty-requestlog.xml
sed -i 's,<Property name="jetty.home" default="." />/webapps,/srv/jetty/webapps,' /opt/jetty/etc/jetty-webapps.xml
sed -i 's,<Property name="jetty.home" default="." />/contexts,/srv/jetty/contexts,' /opt/jetty/etc/jetty-webapps.xml
sed -i '/dirAllowed/ { N; s,true,false, }' /opt/jetty/etc/webdefault.xml
