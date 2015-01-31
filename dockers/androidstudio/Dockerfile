FROM nikowoot/java:default
MAINTAINER Nicolas GAUTIER <ngautier@enroot.fr>

## ================================
## CONFIGURATION SOFTWARE PART
## ================================
# ==> Android STUDIO URL (zip file)
ENV ANDROID_STUDIO_URL https://dl.google.com/dl/android/studio/ide-zips/1.0.0/android-studio-ide-135.1629389-linux.zip
# ==> Android SDK URL (tgz file)
ENV ANDROID_SDK_URL http://dl.google.com/android/android-sdk_r24-linux.tgz

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

## ================================
## LAUNCH PART
## ================================
# Expose sockets
EXPOSE 22

# Launch run script
CMD /run.sh