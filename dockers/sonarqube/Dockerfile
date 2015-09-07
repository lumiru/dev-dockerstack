FROM lumiru/java-oracle
MAINTAINER Frédéric TURPIN <lumiru@turp.in>

## ================================
## INSTALLATION PART
## ================================

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
								   apt-get install -y procps && \
								   apt-get clean && \
								   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget http://dist.sonar.codehaus.org/sonarqube-5.1.zip -O /opt/sonarqube.zip
RUN cd /opt && unzip sonarqube.zip  && rm sonarqube.zip && mv sonarqube-* sonarqube

RUN wget http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip -O /opt/sonar-runner.zip
RUN cd /opt && unzip sonar-runner.zip  && rm sonar-runner.zip && mv sonar-runner-* sonar-runner

RUN wget https://github.com/SonarSource/sonar-examples/archive/master.zip -O /opt/sonar-examples.zip
RUN cd /opt && unzip sonar-examples.zip  && rm sonar-examples.zip && mv sonar-examples-* sonar-examples

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
