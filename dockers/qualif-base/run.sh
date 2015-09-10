#!/bin/bash

# =========================================
# Generate password (for production)
# =========================================
# $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

# =========================================
# Launch HTTPD
# =========================================
# Read file /etc/apache2/envvars
source /etc/apache2/envvars

service php5-fpm start
service ssh start

# =========================================
# Launch httpd
# =========================================
apache2 -D FOREGROUND
