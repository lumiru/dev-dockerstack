FROM easycom/base
MAINTAINER Frédéric TURPIN <lumiru@turp.in>

ENV COUCHDB_TARBALL_URL http://mirror.tcpdiag.net/apache/couchdb/source/1.6.1/apache-couchdb-1.6.1.tar.gz

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

## ================================
## LAUNCH PART
## ================================
# Expose sockets
EXPOSE 80 443

# Launch run script
CMD /run.sh