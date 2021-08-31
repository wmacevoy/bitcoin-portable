#!/bin/sh

os="`uname`"
if [ "$os" = "Darwin" ]
then
    BITCOIN_CORE_OS=osx64
elif [ "$os" = "Linux" ]
then
    BITCOIN_CORE_OS=x86_64-linux-gnu
else
    echo "unknown os."
    exit 1
fi

BITCOIN_CORE_VERSION=0.21.1
BITCOIN_CORE_URL=https://bitcoin.org/bin/bitcoin-core-$BITCOIN_CORE_VERSION/bitcoin-$BITCOIN_CORE_VERSION-$BITCOIN_CORE_OS.tar.gz
BITCOIN_CORE_EXECUTABLE="$at/bitcoin-$BITCOIN_CORE_VERSION-$BITCOIN_CORE_OS/bin/bitcoin-qt"
