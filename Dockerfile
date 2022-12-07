FROM debian:stable

RUN add-apt-repository ppa:bitcoin/bitcoin && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    				   time curl build-essential gdb cmake git nano python3 bitcoind \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

VOLUME /data
EXPOSE 8333
EXPOSE 18333
CMD ["/usr/bin/bitcoind", "-datadir=/data", "--printtoconsole"]