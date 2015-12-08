#!/bin/bash

# =========================================
# Generate password (for production)
# =========================================
# $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

# =========================================
# Activate SSHD, if variable is defined
# =========================================
if [ -n "$SSH_ROOT_PASSWORD" ]; then

	# =========================================
	# Change Root Password
	# =========================================
    echo "root:$SSH_ROOT_PASSWORD" | chpasswd

    # =========================================
	# Print in file and console
	# =========================================
    echo "SSHD ==> root:$SSH_ROOT_PASSWORD"
    echo "SSHD ==> root:$SSH_ROOT_PASSWORD" > /sshd.txt

    # ============================================
	# SSHD - Configure access by Password or PAM
	# ============================================
	sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin no/' /etc/ssh/sshd_config
	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

	# =========================================
	# Launch SSHD
	# =========================================
	/usr/sbin/sshd -D
fi

# =========================================
# Configure Redmine
# =========================================
if [ ! -f ~/firstrun ]; then
	echo "production:
  adapter: mysql2
  database: $SQL_DB
  port: $SQL_PORT
  host: $SQL_HOST
  username: $SQL_USER
  password: $SQL_PASS
  encoding: utf8" > /opt/redmine/config/database.yml

	cd /opt/redmine

	source /usr/local/rvm/scripts/rvm

	DEBIAN_FRONTEND=noninteractive RAILS_ENV=production bundle exec rake db:migrate
	DEBIAN_FRONTEND=noninteractive RAILS_ENV=production REDMINE_LANG=fr bundle exec rake redmine:load_default_data
	DEBIAN_FRONTEND=noninteractive bundle exec rake generate_secret_token

	touch /opt/redmine/tmp/restart.txt

	# Save firstrun
	echo "true" > ~/firstrun
fi

# =========================================
# Launch NginX
# =========================================
echo "=> Launch NginX"
/opt/nginx/sbin/nginx
