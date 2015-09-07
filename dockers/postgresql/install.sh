#!/bin/bash

# =======================================
# Update apt-cache and install PostgreSQL
# =======================================
DEBIAN_FRONTEND=noninteractive  apt-get update && \
                                apt-get -yq --force-yes --no-install-recommends install postgresql-${POSTGRES_VERSION} \
                                                                                        postgresql-client-${POSTGRES_VERSION} \
                                                                                        postgresql-contrib-${POSTGRES_VERSION} && \
                                apt-get clean && \
                                rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
