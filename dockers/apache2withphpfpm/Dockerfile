FROM lumiru/base
MAINTAINER Frédéric TURPIN <lumiru@turp.in>

## ================================
## INSTALLATION PART
## ================================
# Copy, change rights, execute, delete script file "install.sh"
ADD ./install.sh /install.sh
RUN chmod 755 /install.sh
RUN /install.sh
RUN rm -f /install.sh

# Copy, change rights "run.sh"
ADD ./run.sh /run.sh
RUN chmod 755 /run.sh

# Copy "000-default.conf" in Apache2 sites-available
ADD ./000-default.conf /etc/apache2/sites-available/default.conf
RUN chmod 655 /etc/apache2/sites-available/default.conf

# Copy "php5-fpm.conf" in Apache2 conf-available
ADD ./php5-fpm.conf /etc/apache2/conf-available/php5-fpm.conf
RUN chmod 655 /etc/apache2/conf-available/php5-fpm.conf

## ================================
## LAUNCH PART
## ================================
# Expose sockets
EXPOSE 80 443

# Launch run script
CMD /run.sh