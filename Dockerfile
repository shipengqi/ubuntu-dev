ARG UBUNTU_VERSION=18.04
FROM ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    GOLANG_VERSION=1.13.4 \
    NODE_VERSION=12.16.1

# Force timezone, refer to https://stackoverflow.com/a/47909037
RUN echo "tzdata tzdata/Areas select Asia" > /tmp/preseed.txt; \
    echo "tzdata tzdata/Zones/Asia select Shanghai" >> /tmp/preseed.txt; \
    debconf-set-selections /tmp/preseed.txt && \
    rm -rf /etc/timezone /etc/localtime && \
    apt-get update &&\
    apt-get install -y \
      tzdata \
      apt-transport-https \
      ca-certificates \
      curl \
      libcurl4-openssl-dev \
      s3cmd \
      sudo \
      unzip \
      vim \
      zip \
      aufs-tools \
      autoconf \
      automake \
      build-essential \
      cvs \
      git \
      mercurial \
      reprepro \
      subversion \
      make \
      gcc \
      g++ \
      python \
      bc \
      paxctl &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -fsSLO --compressed https://dl.google.com/go/go$GOLANG_VERSION.linux-amd64.tar.gz && \
    tar -C /usr/local -xf go$GOLANG_VERSION.linux-amd64.tar.gz && \
    rm -rf go$GOLANG_VERSION.linux-amd64.tar.gz && \
    export PATH="/usr/local/go/bin:$PATH" && \
    go version

RUN curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" && \
    tar -C /usr/local -xf "node-v$NODE_VERSION-linux-x64.tar.xz" && \
    rm -rf "node-v$NODE_VERSION-linux-x64.tar.xz" && \
    export PATH="/usr/local/node-v$NODE_VERSION-linux-x64/bin:$PATH" && \
    node -v && \
    npm -v

ENV PATH=$PATH:/usr/local/go/bin:/usr/local/node-v$NODE_VERSION-linux-x64/bin
