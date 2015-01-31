#!/bin/bash

# =========================================
# Update apt-cache and install Apache2
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -y --no-install-recommends install apache2 && \
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
							   					  				          php5-apcu \
							   					  				          php5-dev \
							   					  				          php-pear \
							   					  				          php5-mysql \
							   					  				          php5-memcached \
							   					  				          libapache2-mod-php5 \
							   					  				          curl \
							   					  				          build-essential && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# =========================================
# Activate Apache2 mod_rewrite
# =========================================
DEBIAN_FRONTEND=noninteractive a2enmod rewrite && \
								echo \
"<IfModule mod_rewrite.c>
RewriteEngine On
</IfModule>" >> /etc/apache2/apache2.conf	

# =========================================
# Restart Apache2
# =========================================
/etc/init.d/apache2 reload

# =========================================
# Install composer
# =========================================
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
