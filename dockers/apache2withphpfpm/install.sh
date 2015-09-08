#!/bin/bash

# =========================================
# Update apt-cache and install Apache2
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -y --no-install-recommends install apache2 \
							   											  libapache2-mod-fastcgi && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# =========================================
# Update apt-cache and install PHP5 + extensions
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -y --no-install-recommends install php5 \
																		  php5-cli \
																		  php5-curl \
																		  php5-gd \
																		  php5-imagick \
																		  php5-sqlite \
																		  php5-intl \
																		  php5-mcrypt \
																		  php5-xdebug \
																		  php5-dev \
																		  php-pear \
																		  php5-mysql \
																		  php5-memcached \
																		  curl \
																		  build-essential && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# =========================================
# Activate Apache2 mod_rewrite
# =========================================
DEBIAN_FRONTEND=noninteractive a2enmod actions && \
								a2enmod rewrite && \
								a2enmod deflate && \
								a2enmod headers && \
								a2enmod ssl && \


echo "ServerName $(cat /etc/hostname)" > /etc/apache2/conf-available/servername.conf
a2enconf servername

mkdir _bak
mv /etc/apache2/sites-available/* _bak/
mv _bak /etc/apache2/sites-available/
rm -Rf /etc/apache2/sites-enabled/*

touch /etc/apache2/sites-available/default.conf
a2ensite default

touch /etc/apache2/conf-available/php5-fpm.conf
a2enconf php5-fpm

# =========================================
# Restart Apache2
# =========================================
/etc/init.d/apache2 reload

# =========================================
# Install composer
# =========================================
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
