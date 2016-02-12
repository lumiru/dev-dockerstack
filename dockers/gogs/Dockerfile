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

## ================================
## LAUNCH PART
## ================================
# Expose sockets
EXPOSE 3000

# Launch run script
CMD gogs run web