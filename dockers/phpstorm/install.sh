#!/bin/bash

# ======================================
# PhpStorm 8.0.1
# ======================================
DEBIAN_FRONTEND=noninteractive wget --progress=bar:force -O /root/phpstorm.tgz $PHPSTORM_URL && \
							   mkdir /root/phpstorm && \
                               tar -C /root/phpstorm -xzvf /root/phpstorm.tgz --strip-components 1 && \
                               rm -rf /root/phpstorm.tgz