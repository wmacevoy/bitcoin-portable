#!/bin/sh

os="`uname`"
if [ "$os" = "Darwin" ]
then
    BITCOIN_CORE_OS=x86_64-apple-darwin
elif [ "$os" = "Linux" ]
then
    BITCOIN_CORE_OS=x86_64-linux-gnu
else
    echo "unknown os."
    exit 1
fi

BITCOIN_CORE_VERSION=23.0
BITCOIN_CORE_URL=https://bitcoincore.org/bin/bitcoin-core-$BITCOIN_CORE_VERSION/bitcoin-$BITCOIN_CORE_VERSION-$BITCOIN_CORE_OS.tar.gz
BITCOIN_CORE_URL_SHA256=https://bitcoincore.org/bin/bitcoin-core-$BITCOIN_CORE_VERSION/SHA256SUMS
BITCOIN_CORE_EXECUTABLE="$at/bitcoin-$BITCOIN_CORE_VERSION-$BITCOIN_CORE_OS/bin/bitcoin-qt"
