FROM area51/ubuntu-dev:18.04

ENV GOLANG_VERSION=1.13.4 \
    NODE_VERSION=12.16.1

RUN apt-get update && \
    apt-get install bc -y

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
