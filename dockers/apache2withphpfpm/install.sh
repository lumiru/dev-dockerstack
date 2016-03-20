#!/bin/bash

file=$(cat <<EOF
deb http://httpredir.debian.org/debian jessie non-free
deb http://httpredir.debian.org/debian jessie-updates non-free
deb http://security.debian.org jessie/updates non-free
EOF
)

echo "$file" > /etc/apt/sources.list.d/non-free.list


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
																		  php5-fpm \
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
								a2enmod headers

sed -i 's,#Header,Header,' /etc/apache2/conf-available/security.conf
sed -i 's,#<DirectoryMatch "/\.svn,<DirectoryMatch "/\.git,' /etc/apache2/conf-available/security.conf
sed -i 's,ServerSignature On,ServerSignature Off,' /etc/apache2/conf-available/security.conf
sed -i 's,ServerTokens OS,ServerTokens Prod,' /etc/apache2/conf-available/security.conf
sed -i 's,#   Require all denied,   Require all denied,' /etc/apache2/conf-available/security.conf
sed -i 's,#</DirectoryMatch>,</DirectoryMatch>,' /etc/apache2/conf-available/security.conf

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
