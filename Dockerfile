# Using stretch instead of buster since it still has Java 8 in the official repos
FROM debian:stretch

# Install necessary build tools
RUN \
    apt-get update && \
    apt-get install -y software-properties-common curl python git unzip gradle && \
    curl http://nodejs.org/dist/v9.9.0/node-v9.9.0-linux-x64.tar.gz | tar xz -C /usr/local/ --strip=1 && \
    npm install -g cordova@8.1.0

# With this version of node, the cordova prompt that asks for permission is broken
# so we disable it directly
RUN cordova telemetry off

# Install Java
RUN apt-get update && apt-get install -y openjdk-8-jdk

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

# Install Android SDK
# Update to latest version if necessary from https://developer.android.com/studio#downloads
RUN curl https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -o temp.zip
RUN unzip -q -u -d /usr/local/android-sdk-linux temp.zip
RUN rm temp.zip

# Use ANDROID_SDK_ROOT instead
ENV ANDROID_SDK_ROOT /usr/local/android-sdk-linux

#Add ANDROID_SDK_ROOT to PATH
ENV PATH $PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH:$ANDROID_SDK_ROOT/tools/bin

# Accept all licenses s.t. the subsequent installs succeed
RUN yes | sdkmanager --licenses

# Install Android 28 tools
RUN sdkmanager "build-tools;28.0.3" "platforms;android-28" "platform-tools"
