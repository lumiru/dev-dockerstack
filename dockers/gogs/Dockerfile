FROM easycom/base
MAINTAINER Frédéric TURPIN <lumiru@turp.in>

## ================================
## INSTALLATION PART
## ================================
# Copy, change rights, execute, delete script file "install.sh"
ADD ./install.sh /install.sh
RUN chmod 755 /install.sh
RUN /install.sh
RUN rm -f /install.sh

ADD ./sshd_config /etc/ssh/sshd_config

## ================================
## LAUNCH PART
## ================================
# Expose sockets
EXPOSE 3000 22

# Launch run script
CMD service cron start; service ssh start; gogs run web
