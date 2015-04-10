FROM nikowoot/java-default
MAINTAINER Frédéric TURPIN <lumiru@turp.in>

## ================================
## CONFIGURATION SOFTWARE PART
## ================================
# ==> Jetty URL (deb file)
ENV JETTY_URL http://central.maven.org/maven2/org/mortbay/jetty/dist/jetty-deb/8.1.15.v20140411/jetty-deb-8.1.15.v20140411.deb

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