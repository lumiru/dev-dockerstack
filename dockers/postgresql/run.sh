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
    /usr/sbin/sshd -D
fi

# =========================================
# Configure Postgresql
# =========================================
if [ ! -f /root/install_postgresql ]; then

    # Listen on all interfaces
    echo "host    all    all    0.0.0.0/0    md5" >>  /etc/postgresql/${POSTGRES_VERSION}/main/pg_hba.conf && \
    sed -e "s/data_directory =.*$/data_directory = '\/data'/" -i /etc/postgresql/${POSTGRES_VERSION}/main/postgresql.conf && \
    sed -e "s/^#listen_addresses =.*$/listen_addresses = '*'/" -i /etc/postgresql/${POSTGRES_VERSION}/main/postgresql.conf

    # Check if volume is not mapped on this directory
    if [ ! -d /data ]; then
        # Init database PostgreSQL, change rights in /data
        mkdir /data && \
        chown -R postgres:postgres /data && \
        sudo -u postgres /usr/lib/postgresql/${POSTGRES_VERSION}/bin/initdb -E 'UTF-8' -D /data && \
        ln -s /etc/ssl/certs/ssl-cert-snakeoil.pem /data/server.crt && \
        ln -s /etc/ssl/private/ssl-cert-snakeoil.key /data/server.key
    fi

    # Create log temp directory
    mkdir -p /var/run/postgresql/9.4-main.pg_stat_tmp/ && \
    chown -R postgres:postgres /var/run/postgresql/9.4-main.pg_stat_tmp/

    # Start PostgreSQL
    sudo -u postgres /usr/lib/postgresql/${POSTGRES_VERSION}/bin/postgres \
        --config-file=/etc/postgresql/${POSTGRES_VERSION}/main/postgresql.conf &

    while ! nc -vz localhost 5432; do sleep 1; done

    # Create new User with Admin rights
    if [ -n "$POSTGRES_USERNAME" ] && [ -n "$POSTGRES_PASSWORD" ] && [ -n "$POSTGRES_DATABASE" ]; then

        # Print in file and STDOUT
        echo "=> Create new user $POSTGRES_USERNAME:$POSTGRES_PASSWORD with DB : $POSTGRES_DATABASE"
        echo "$POSTGRES_USERNAME:$POSTGRES_PASSWORD with DB : $POSTGRES_DATABASE" > /postgresql.txt
        sudo -u postgres /usr/lib/postgresql/${POSTGRES_VERSION}/bin/psql -U postgres -c \
            "CREATE USER ${POSTGRES_USERNAME} WITH ENCRYPTED PASSWORD '${POSTGRES_PASSWORD}' CREATEDB;"

        echo "=> Create Database: \"$POSTGRES_DATABASE\"..."
        sudo -u postgres /usr/lib/postgresql/${POSTGRES_VERSION}/bin/psql -U postgres -c \
            "CREATE DATABASE ${POSTGRES_DATABASE} OWNER ${POSTGRES_USERNAME} TEMPLATE DEFAULT;"

        echo "=> User : \"$POSTGRES_USERNAME\" is now admin"
        sudo -u postgres /usr/lib/postgresql/${POSTGRES_VERSION}/bin/psql -U postgres -c \
            "ALTER USER ${POSTGRES_USERNAME} WITH SUPERUSER;"
    fi

    # Stop PostgreSQL
    kill -INT `head -1 /data/postmaster.pid`
    while nc -vz localhost 5432; do sleep 1; done

    # Save install_postgresql
    echo "true" > /root/install_postgresql
fi

# =========================================
# Launch PostgreSQL
# =========================================
sudo -u postgres /usr/lib/postgresql/${POSTGRES_VERSION}/bin/postgres \
    --config-file=/etc/postgresql/${POSTGRES_VERSION}/main/postgresql.conf
