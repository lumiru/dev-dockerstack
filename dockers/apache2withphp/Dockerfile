FROM nikowoot/base
MAINTAINER Nicolas GAUTIER <ngautier@enroot.fr>

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
ADD ./000-default.conf /etc/apache2/sites-available/000-default.conf
RUN chmod 655 /etc/apache2/sites-available/000-default.conf

## ================================
## LAUNCH PART
## ================================
# Expose sockets
EXPOSE 22 80 443

# Launch run script
CMD /run.sh