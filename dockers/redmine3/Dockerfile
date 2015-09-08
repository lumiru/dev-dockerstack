FROM easycom/passenger
MAINTAINER Frédéric TURPIN <lumiru@turp.in>

## ================================
## CONFIGURATION SOFTWARE PART
## ================================

# Redmine URL (archive)
ENV REDMINE_URL http://svn.redmine.org/redmine/branches/3.0-stable
ENV SQL_HOST 127.0.0.1
ENV SQL_PORT 3306
ENV SQL_DB redmine
ENV SQL_USER redmine
ENV SQL_PASS redmine

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
EXPOSE 80

# Launch run script
CMD /run.sh
