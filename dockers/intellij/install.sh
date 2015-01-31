#!/bin/bash

# ======================================
# Download and install build-essential (requirement for GO)
# ======================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -yq --force-yes --no-install-recommends install build-essential && \
    						   apt-get clean && \
    						   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ======================================
# Download and install Intellij
# ======================================
DEBIAN_FRONTEND=noninteractive wget --progress=bar:force -O /root/intellij.tgz $INTELLIJ_URL && \
							   mkdir /root/intellij && \
                               tar -C /root/intellij -xzvf /root/intellij.tgz --strip-components 1 && \
                               rm -rf /root/intellij.tgz
	
# ======================================
# Download and install Go environnement
# ======================================
DEBIAN_FRONTEND=noninteractive wget --progress=bar:force -O /root/go-lang.tar.gz $GOENV_URL && \
							   tar -C /usr/local -xzvf /root/go-lang.tar.gz --strip-components 1 && \
							   rm -rf /root/go-lang.tar.gz && \
							   mkdir -p /data/bin /data/pkg /data/src

# ======================================
# Download and install Go plugin for Intellij
# ======================================
DEBIAN_FRONTEND=noninteractive mkdir -p /root/intellij/plugins/google-go-language/lib && \
							   wget --progress=bar:force -O /root/intellij/plugins/google-go-language/lib/google-go-language.jar $GOPLUGIN_URL



