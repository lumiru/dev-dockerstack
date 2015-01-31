#!/bin/bash

# =========================================
# Generate password (for production)
# =========================================
# $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

	# =========================================
	# Configure Phabricator
	# =========================================
if [ ! -f /root/install_phabricator ]; then

	# Configure Phabricator Base-uri (Obligatory to configure VCS server)
	./var/www/html/phabricator/bin/config set phabricator.base-uri $PHABRICATOR_BASEURI

	# Configure MySQL Database
	./var/www/html/phabricator/bin/config set mysql.port $SQL_PORT && \
	./var/www/html/phabricator/bin/config set mysql.user $SQL_USER && \
	./var/www/html/phabricator/bin/config set mysql.pass $SQL_PASS && \
	./var/www/html/phabricator/bin/config set mysql.host $SQL_HOST

	# Install Database
	./var/www/html/phabricator/bin/storage upgrade --force

	# Configure SMTP Server
	./var/www/html/phabricator/bin/config set metamta.mail-adapter PhabricatorMailImplementationPHPMailerAdapter && \
	./var/www/html/phabricator/bin/config set metamta.default-address $EMAIL_DEFAULT && \
	./var/www/html/phabricator/bin/config set metamta.domain $EMAIL_DOMAIN && \
	./var/www/html/phabricator/bin/config set phpmailer.mailer smtp && \
	./var/www/html/phabricator/bin/config set phpmailer.smtp-host $SMTP_HOST && \
	./var/www/html/phabricator/bin/config set phpmailer.smtp-port $SMTP_PORT && \
	./var/www/html/phabricator/bin/config set phpmailer.smtp-user $SMTP_USER && \
	./var/www/html/phabricator/bin/config set phpmailer.smtp-password $SMTP_PASSWORD && \
	./var/www/html/phabricator/bin/config set phpmailer.smtp-protocol $SMTP_PROTOCOL && \
	./var/www/html/phabricator/bin/config set phpmailer.smtp-encoding $SMTP_ENCODING

    ./conf_phabricator_gitandssh.sh

	# Write file
	touch /root/install_phabricator
fi

# =========================================
# Launch Php5-fpm, Phabricator Daemon and nginx
# =========================================
service php5-fpm start && su -c "/var/www/html/phabricator/bin/phd start" -s /bin/bash phabricator && nginx
