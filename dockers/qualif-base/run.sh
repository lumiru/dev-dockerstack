#!/bin/bash

# =========================================
# Generate password (for production)
# =========================================
# $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
if [ ! -f ~/firstrun ]; then
	HTDOCS_HOMES="/srv/web"

	PASSWD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
	if [ -f $HTDOCS_HOMES/default/.pass ]; then
		PASSWD=`cat $HTDOCS_HOMES/default/.pass`
	else
		echo $PASSWD > $HTDOCS_HOMES/default/.pass
	fi

	adduser --home=$HTDOCS_HOMES/default --disabled-password easycom
	adduser easycom sudo
	usermod --password=`openssl passwd $PASSWD` easycom

	mkdir -p $HTDOCS_HOMES/default/htdocs
	mkdir -p $HTDOCS_HOMES/default/log

	chown -Rf easycom:easycom $HTDOCS_HOMES/default
	chmod 0400 $HTDOCS_HOMES/default/.pass

	HTDOCS_DIRS=`find $HTDOCS_HOMES -mindepth 1 -maxdepth 1 -type d`
	for file in $HTDOCS_DIRS; do
		if [ $file = '/srv/web/default' ]; then
			continue
		fi

		USERNAME=`basename $file`
		PASSWD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
		if [ ! -f $file/.pass ]; then
			PASSWD=`cat $file/.pass`
		else
			echo $PASSWD > $file/.pass
		fi

		mkdir -p $file/htdocs
		mkdir -p $file/log

		adduser --home=$file --no-create-home --disabled-password $USERNAME
		adduser $USERNAME sudo
		usermod --password=`openssl passwd $PASSWD` $USERNAME

		chown -Rf $USERNAME:$USERNAME $file
		chmod 0400 $file/.pass
	done

	# Save firstrun
	echo "Please do not remove this file" > ~/firstrun
fi

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
