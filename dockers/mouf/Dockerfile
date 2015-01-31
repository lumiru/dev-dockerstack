FROM nikowoot/nginxwithphpfpm
MAINTAINER Nicolas GAUTIER <ngautier@enroot.fr>

## ================================
## INSTALLATION PART
## ================================

# Copy, change rights "run.sh"
ADD ./run.sh /run.sh
RUN chmod 755 /run.sh

# Copy default-website for Nginx
ADD ./site-default /etc/nginx/sites-available/default

## ================================
## LAUNCH PART
## ================================
# Expose sockets
EXPOSE 22 80 443

# Launch run script
CMD /run.sh