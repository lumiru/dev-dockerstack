FROM nikowoot/nginxwithphpfpm
MAINTAINER Nicolas GAUTIER <ngautier@enroot.fr>

## ================================
## CONFIGURATION PART
## ================================
ENV PHABRICATOR_BASEURI http://127.0.0.1/
ENV SQL_HOST 127.0.0.1
ENV SQL_PORT 3306
ENV SQL_USER admin
ENV SQL_PASS admin

ENV SMTP_HOST smtp.test.com
ENV SMTP_PORT 465
ENV SMTP_USER user@test.com
ENV SMTP_PASSWORD test
ENV SMTP_PROTOCOL ssl
ENV SMTP_ENCODING 8bit

ENV EMAIL_DOMAIN test.com
ENV EMAIL_DEFAULT no-reply@test.com

## ================================
## INSTALLATION PART
## ================================
# Copy, change rights, execute, delete script file "install.sh"
ADD ./install.sh /install.sh
RUN chmod 755 /install.sh
RUN /install.sh
RUN rm -f /install.sh

# Copy, change rights, execute, delete script file "conf_phabricator_gitandssh.sh"
ADD ./conf_phabricator_gitandssh.sh /conf_phabricator_gitandssh.sh
RUN chmod 755 /conf_phabricator_gitandssh.sh

# Copy, change rights "run.sh"
ADD ./run.sh /run.sh
RUN chmod 755 /run.sh

# Copy default-website for Nginx
ADD ./site-default /etc/nginx/sites-available/default

## ================================
## LAUNCH PART
## ================================
# Expose sockets
EXPOSE 22 80 443

# Launch run script
CMD /run.sh
