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
	# Launch SSHD in daemon
	# =========================================
	echo "=> Launch SSHD"
	/usr/sbin/sshd -D
fi

# =========================================
# Launch Memcached
# =========================================
echo "=> Launch Memcached with parameters :
MEMCACHED_IP = $MEMCACHED_IP
MEMCACHED_SIZE = $MEMCACHED_SIZE
MEMCACHED_CONCURENT = $MEMCACHED_CONCURENT
MEMCACHED_THREAD = $MEMCACHED_THREAD"

/usr/bin/memcached -u root \
				   -l $MEMCACHED_IP \
				   -m $MEMCACHED_SIZE \
				   -c $MEMCACHED_CONCURENT \
				   -t $MEMCACHED_THREAD \
				   -v
# If I want use Authentification for Memcached (later)
# -S <= Active SASL
#/usr/bin/memcached -S
