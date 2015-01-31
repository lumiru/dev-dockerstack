FROM nikowoot/java:default
MAINTAINER Nicolas GAUTIER <ngautier@enroot.fr>

## ================================
## CONFIGURATION SOFTWARE PART
## ================================
# ==> Intellij URL (tgz file)
ENV INTELLIJ_URL http://download-cf.jetbrains.com/idea/ideaIU-14.0.2.tar.gz
ENV GOENV_URL https://storage.googleapis.com/golang/go1.4.linux-amd64.tar.gz
ENV GOPLUGIN_URL https://plugins.jetbrains.com/files/5047/14982/google-go-language.jar

## ================================
## CONFIGURATION USER PART
## ================================
ENV USER_ID 1000
ENV GROUP_ID 1000
ENV USER_NAME developer
ENV USER_TITLE Developer

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

## ============================================
## CREATE AN USER + WORKSPACE + SUDO rights
## ============================================

RUN export uid=$USER_ID gid=$GROUP_ID && \
    mkdir -p /home/$USER_NAME && \
    echo "$USER_NAME:x:${uid}:${gid}:$USER_TITLE,,,:/home/$USER_NAME:/bin/bash" >> /etc/passwd && \
    echo "$USER_NAME:x:${uid}:" >> /etc/group && \
    echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER_NAME && \
    chmod 0440 /etc/sudoers.d/$USER_NAME && \
    chown ${uid}:${gid} -R /home/$USER_NAME

USER root

ENV GOPATH /data
ENV PATH $PATH:/usr/local/go/bin:/$GOPATH/bin

## ================================
## LAUNCH PART
## ================================
# Expose sockets
EXPOSE 22

# Launch run script
CMD /run.sh