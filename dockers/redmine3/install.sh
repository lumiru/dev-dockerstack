#!/bin/bash

# =========================================
# Install software dependancies
# =========================================

DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get install -y libmysqlclient-dev subversion && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# =========================================
# Install software (Redmine)
# =========================================

mkdir /opt
cd /opt/
svn co $REDMINE_URL redmine

cd /opt/redmine

echo "production:
  adapter: mysql2
  database: $SQL_DB
  port: $SQL_PORT
  host: $SQL_HOST
  username: $SQL_USER
  password: $SQL_PASS
  encoding: utf8" > config/database.yml

source /usr/local/rvm/scripts/rvm
bundle install --without postgresql sqlite development test rmagick

mkdir public/plugin_assets
chown -R www-data:www-data files log tmp public/plugin_assets config.ru
chmod -R 755 files log tmp public/plugin_assets
