#!/bin/bash

# =========================================
# Generate password (for production)
# =========================================
# $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)


# Start service manager
echo "Starting services..."
/opt/gitlab/embedded/bin/runsvdir-start &

# Configure gitlab package
echo "Configuring GitLab..."
gitlab-ctl reconfigure

# Tail all logs
gitlab-ctl tail &

# Wait for SIGTERM
wait
