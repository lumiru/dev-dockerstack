FROM ubuntu:14.04
MAINTAINER Nicolas GAUTIER <ngautier@enroot.fr>

## ================================
## WORKAROUND PART
## ================================
ENV HOME /root

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
EXPOSE 22

# Launch run script
CMD /run.sh