FROM lumiru/base
MAINTAINER Frédéric TURPIN <lumiru@turp.in>

## ================================
## CONFIGURATION PART
## ================================
ENV POSTGRES_VERSION 9.4
ENV POSTGRES_USERNAME admin
ENV POSTGRES_PASSWORD admin
ENV POSTGRES_DATABASE admin_defaultdb

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
EXPOSE 5432

# Launch run script
CMD /run.sh
