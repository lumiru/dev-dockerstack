#!/bin/bash

# =========================================
# Update apt-cache and install softwares (Open-JRE, Open-JDK)
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get install -yq --force-yes --no-install-recommends default-jre \
						   															   default-jdk && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*