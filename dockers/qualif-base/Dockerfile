FROM easycom/apache2withphpfpm
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

# Copy "bashrc" in root's home
ADD ./bashrc /root/.bashrc
RUN chmod 755 /run.sh

## ================================
## LAUNCH PART
## ================================
# Expose sockets
EXPOSE 80 443

# Launch run script
CMD /run.sh