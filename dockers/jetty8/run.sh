#!/bin/bash

# =========================================
# Generate password (for production)
# =========================================
# $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

# =========================================
# Launch Bash (basic image)
# =========================================

ulimit -n 100000

/etc/init.d/jetty run
