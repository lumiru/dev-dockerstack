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
	sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

	# =========================================
	# Launch SSHD
	# =========================================
	/usr/sbin/sshd -D
fi

# =========================================
# Launch Bash (basic image)
# =========================================
/etc/init.d/jetty run
