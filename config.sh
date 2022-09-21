#!/bin/sh

os="`uname`"
if [ "$os" = "Darwin" ]
then
    BITCOIN_CORE_OS=$(uname -m)-apple-darwin
elif [ "$os" = "Linux" ]
then
    if grep -q Microsoft /proc/version
    then
        BITCOIN_CORE_OS=win64
    else
        BITCOIN_CORE_OS=$(uname -m)-linux-gnu
    fi
elif [[ "$os" =~ ^MINGW ]]
then
    BITCOIN_CORE_OS=win64
fi


BITCOIN_CORE_VERSION=23.0

if [ $BITCOIN_CORE_OS != "win64" ]
then
    BITCOIN_CORE_URL=https://bitcoincore.org/bin/bitcoin-core-$BITCOIN_CORE_VERSION/bitcoin-$BITCOIN_CORE_VERSION-$BITCOIN_CORE_OS.tar.gz
    BITCOIN_CORE_EXTENSION=""
else
    BITCOIN_CORE_URL=https://bitcoincore.org/bin/bitcoin-core-$BITCOIN_CORE_VERSION/bitcoin-$BITCOIN_CORE_VERSION-$BITCOIN_CORE_OS.zip
    BITCOIN_CORE_EXTENSION=".exe"
fi

BITCOIN_CORE_URL_SHA256=https://bitcoincore.org/bin/bitcoin-core-$BITCOIN_CORE_VERSION/SHA256SUMS

BITCOIN_CORE_EXECUTABLE="$at/bitcoin-$BITCOIN_CORE_VERSION-$BITCOIN_CORE_OS/bin/bitcoin-qt$BITCOIN_CORE_EXTENSION"
BITCOIND_CORE_EXECUTABLE="$at/bitcoin-$BITCOIN_CORE_VERSION-$BITCOIN_CORE_OS/bin/bitcoind$BITCOIN_CORE_EXTENSION"
BITCOIN_CLI_CORE_EXECUTABLE="$at/bitcoin-$BITCOIN_CORE_VERSION-$BITCOIN_CORE_OS/bin/bitcoin-cli$BITCOIN_CORE_EXTENSION"
