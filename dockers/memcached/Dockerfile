FROM lumiru/base
MAINTAINER Frédéric TURPIN <lumiru@turp.in>

## ================================
## CONFIGURATION SOFTWARE PART
## ================================
ENV MEMCACHED_SIZE 64
ENV MEMCACHED_CONCURENT 1024
ENV MEMCACHED_IP 0.0.0.0
ENV MEMCACHED_THREAD 4

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
EXPOSE 11211

# Launch run script
CMD /run.sh