FROM lumiru/nodejs
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

## ================================
## LAUNCH PART
## ================================
# Expose sockets
EXPOSE 2368

# Move user to ghost directory
WORKDIR /data/ghost

# Launch run script
CMD /run.sh