#!/bin/bash

# =========================================
# Update apt-cache and install EngineX (NginX)
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -y --no-install-recommends install nginx && \
							   apt-get clean && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



# =========================================
# Update apt-cache and install PHP-FPM
# =========================================
DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get -y --no-install-recommends install php5-fpm \
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
							   					  				          php5-memcache \
							   					  				          php5-memcached \
							   											  curl && \
							   apt-get clean && \
							   sed -e "s/^\;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" -i /etc/php5/fpm/php.ini && \
							   sed -e "s/^listen = 127.0.0.1:9000/listen = \/var\/run\/php5-fpm.sock/g" -i /etc/php5/fpm/pool.d/www.conf && \
							   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
							   mkdir -p /var/www/html

# =========================================
# Install composer
# =========================================
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
