#!/bin/bash

# =========================================
# Generate password (for production)
# =========================================
# $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

# =========================================
# Launch NginX
# =========================================
echo "=> Launch NginX"
/opt/nginx/sbin/nginx
