#!/bin/bash

# ======================================
# Android Studio 0.8.14
# ======================================
DEBIAN_FRONTEND=noninteractive wget --progress=bar:force -O /root/android-studio.zip $ANDROID_STUDIO_URL && \
							   mkdir /root/android-studio && \
                               unzip /root/android-studio.zip -d /root/android-studio && \
                               rm -rf /root/android-studio.zip


# ======================================
# Android SDK 23.02
# ======================================
DEBIAN_FRONTEND=noninteractive wget --progress=bar:force -O /root/android-sdk.tgz $ANDROID_SDK_URL && \
							   mkdir /root/android-sdk && \
                               tar -C /root/android-sdk -xzvf /root/android-sdk.tgz --strip-components 1 && \
                               rm -rf /root/android-sdk.tgz
