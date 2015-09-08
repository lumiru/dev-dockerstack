FROM easycom/base
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

# Copy default-website for Nginx
ADD ./site-default /etc/nginx/sites-available/default

# Copy nginx configuration
ADD ./nginx.conf /etc/nginx/nginx.conf

## ================================
## LAUNCH PART
## ================================
# Expose sockets
EXPOSE 80 443

# Launch run script
CMD /run.sh