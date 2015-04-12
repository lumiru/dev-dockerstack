#!/bin/bash

# =========================================
# Install software dependancies
# =========================================

DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get install -y libmysqlclient-dev git git-core libcurl4-openssl-dev curl && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# =========================================
# Install RVM
# =========================================

gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
curl -L https://get.rvm.io | bash -s stable --ruby=2.1

source /usr/local/rvm/scripts/rvm
echo '[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"' >> ~/.bashrc

# =========================================
# Install passenger (CGI interface)
# =========================================

gem install passenger bundler --no-ri --no-rdoc
passenger-install-nginx-module

git clone git://github.com/jnstq/rails-nginx-passenger-ubuntu.git
mv rails-nginx-passenger-ubuntu/nginx/nginx /etc/init.d/nginx
chown root:root /etc/init.d/nginx
update-rc.d nginx defaults

# =========================================
# Install software (Redmine)
# =========================================

mkdir /opt
cd /opt/

wget -nv --progress=bar:force -O /opt/redmine.tgz $REDMINE_URL
tar xfz /opt/redmine.tgz
rm -rf /opt/redmine.tgz /var/lib/apt/lists/* /tmp/* /var/tmp/*
mv redmine-* redmine

cd /opt/redmine

echo "production:
  adapter: mysql2
  database: $SQL_DB
  port: $SQL_PORT
  host: $SQL_HOST
  username: $SQL_USER
  password: $SQL_PASS
  encoding: utf8" > config/database.yml

bundle install --without postgresql sqlite development test rmagick

mkdir public/plugin_assets
chown -R www-data:www-data files log tmp public/plugin_assets config.ru
chmod -R 755 files log tmp public/plugin_assets
