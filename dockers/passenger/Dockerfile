FROM nikowoot/base
MAINTAINER Frédéric TURPIN <lumiru@turp.in>

## ================================
## INSTALLATION PART
## ================================

# Copy, change rights, execute, delete script file "install.sh"
ADD ./install.sh /install.sh
RUN chmod 755 /install.sh
RUN /install.sh
RUN rm -f /install.sh

ADD ./nginx.conf /opt/nginx/conf/nginx.conf

# Copy, change rights "run.sh"
ADD ./run.sh /run.sh
RUN chmod 755 /run.sh

## ================================
## LAUNCH PART
## ================================
# Expose sockets
EXPOSE 22 80

# Launch run script
CMD /run.sh
