FROM easycom/mariadb
MAINTAINER Frédéric TURPIN <lumiru@turp.in>

## ================================
## INSTALLATION PART
## ================================

RUN wget http://repo.zabbix.com/zabbix/2.4/debian/pool/main/z/zabbix-release/zabbix-release_2.4-1+wheezy_all.deb
RUN DEBIAN_FRONTEND=noninteractive dpkg -i zabbix-release_2.4-1+wheezy_all.deb && \
								   apt-get update && \
								   apt-get install -y zabbix-frontend-php zabbix-agent && \
								   apt-get clean && \
								   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "php_value max_execution_time 300\nphp_value memory_limit 128M\n\
php_value post_max_size 16M\nphp_value upload_max_filesize 2M\nphp_value max_input_time 300\
\nphp_value date.timezone Europe/Paris" >> /etc/apache2/conf.d/zabbix

RUN DEBIAN_FRONTEND=noninteractive service mysql start && \
								   apt-get update && \
								   apt-get install -y --no-install-recommends zabbix-server-mysql && \
								   apt-get clean && \
								   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

# Copy, change rights, execute, delete script file "install.sh"
# ADD ./install.sh /install.sh
# RUN chmod 755 /install.sh
# RUN /install.sh
# RUN rm -f /install.sh

# Copy, change rights "run.sh"
# ADD ./run.sh /run.sh
# RUN chmod 755 /run.sh

# Launch run script
# CMD /opt/sonarqube/bin/linux-x86-64/sonar.sh console
# CMD cd /opt/sonar-examples/projects/languages/java/sonar-runner/java-sonar-runner-simple && /opt/sonar-runner/bin/sonar-runner
CMD bash -i
