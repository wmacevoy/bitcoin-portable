#!/bin/sh

os="`uname`"
if [ "$os" = "Darwin" ]
then
    BITCOIN_CORE_OS=osx64
fi

BITCOIN_CORE_VERSION=0.19.1
BITCOIN_CORE_URL=https://bitcoin.org/bin/bitcoin-core-$BITCOIN_CORE_VERSION/bitcoin-$BITCOIN_CORE_VERSION-$BITCOIN_CORE_OS.tar.gz
