#!/bin/bash

# =======================================
# Update apt-cache and install PostgreSQL
# =======================================
DEBIAN_FRONTEND=noninteractive  echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
                                wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - && \
                                apt-get update && \
                                apt-get -yq --force-yes --no-install-recommends install postgresql-${POSTGRES_VERSION} \
                                                                                        postgresql-client-${POSTGRES_VERSION} \
                                                                                        postgresql-contrib-${POSTGRES_VERSION} && \
                                apt-get clean && \
                                rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
