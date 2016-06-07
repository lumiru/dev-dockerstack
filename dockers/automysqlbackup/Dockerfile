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

## ================================
## LAUNCH PART
## ================================
# Expose sockets

# Launch run script
CMD automysqlbackup