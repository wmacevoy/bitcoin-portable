#!/bin/bash
# Sourced by the wrapper scripts; uses bash features (BASH_SOURCE, local, &>).
BITCOIN_PORTABLE_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
BITCOIN_PORTABLE_IS_MICROSOFT_WINDOWS() {
    if command -v cygpath > /dev/null 2>&1 # git-bash/msys/cygwin
    then
        return 0
    fi
    if [ -r /proc/version ] && grep -q Microsoft /proc/version
    then
        return 0
    fi
    return 1
}

BITCOIN_PORTABLE_IS_APPLE_DARWIN() {
    if [ "`uname`" = "Darwin" ]
    then
        return 0
    fi
        return 1
}

BITCOIN_PORTABLE_IS_GNU_LINUX() {
    if BITCOIN_PORTABLE_IS_MICROSOFT_WINDOWS
    then
        return 1
    fi
    if [ "`uname`" = "Linux" ]
    then
        return 0
    fi
    return 1
}

BITCOIN_PORTABLE_GET_OS() {
    if BITCOIN_PORTABLE_IS_APPLE_DARWIN
    then
        echo "$(uname -m)-apple-darwin"
    elif BITCOIN_PORTABLE_IS_GNU_LINUX
    then
        echo "$(uname -m)-linux-gnu"
    elif BITCOIN_PORTABLE_IS_MICROSOFT_WINDOWS
    then
        echo "win64"
    else
        echo "unknown"
    fi
}

BITCOIN_PORTABLE_GET_PATH() {
    if command -v cygpath > /dev/null 2>&1 # git-bash/msys/cygwin
    then
        cygpath -w "$@"
    elif [ -r /proc/version ] && grep -q Microsoft /proc/version
    then
    	readlink -m "$@" | sed 's|^/mnt/\([a-z]\)|\U\1:|' | sed 's|/|\\|g'
    else
	    echo "$@"
    fi
}

BITCOIN_PORTABLE_ERR() { 
    echo "$@" 1>&2
    exit 1
}

BITCOIN_PORTABLE_CAT() {
    if command -v curl > /dev/null 2>&1
    then
    	if curl -fsSL "$@"
        then
            return
        fi
    fi
    if command -v wget > /dev/null 2>&1
    then
    	if wget -O - "$@"
        then
            return
        fi
    fi
    BITCOIN_PORTABLE_ERR "CAT $@ failed."
}

BITCOIN_PORTABLE_SHA256() {
    if command -v openssl >/dev/null 2>&1; then
        openssl dgst -sha256 -r | cut -d ' ' -f1
    elif command -v shasum >/dev/null 2>&1; then
        shasum -a 256 | cut -d ' ' -f1
    elif command -v sha256sum >/dev/null 2>&1; then
        sha256sum | cut -d ' ' -f1
    else
        BITCOIN_PORTABLE_ERR "SHA-256 failed."
    fi
}

BITCOIN_PORTABLE_VERSION=31.0
BITCOIN_PORTABLE_OS=$(BITCOIN_PORTABLE_GET_OS)
if BITCOIN_PORTABLE_IS_MICROSOFT_WINDOWS
then
    BITCOIN_PORTABLE_EXE_EXTENSION=".exe"
    BITCOIN_PORTABLE_ARCHIVE_EXTENSION=".zip"
else
    BITCOIN_PORTABLE_EXE_EXTENSION=""
    BITCOIN_PORTABLE_ARCHIVE_EXTENSION=".tar.gz"
fi

BITCOIN_PORTABLE_SUBDIR="bitcoin-$BITCOIN_PORTABLE_VERSION-$BITCOIN_PORTABLE_OS"
BITCOIN_PORTABLE_ARCHIVE="$BITCOIN_PORTABLE_SUBDIR$BITCOIN_PORTABLE_ARCHIVE_EXTENSION"
BITCOIN_PORTABLE_URL=https://bitcoincore.org/bin/bitcoin-core-$BITCOIN_PORTABLE_VERSION/bitcoin-$BITCOIN_PORTABLE_VERSION-$BITCOIN_PORTABLE_OS$BITCOIN_PORTABLE_ARCHIVE_EXTENSION
BITCOIN_PORTABLE_URL_SHA256=https://bitcoincore.org/bin/bitcoin-core-$BITCOIN_PORTABLE_VERSION/SHA256SUMS
BITCOIN_PORTABLE_URL_SHA256_ASC=https://bitcoincore.org/bin/bitcoin-core-$BITCOIN_PORTABLE_VERSION/SHA256SUMS.asc

BITCOIN_PORTABLE_NICE_EXEC() {
    local CMD="$1"
    shift
    if command -v renice > /dev/null 2>&1
    then
        renice -n 10 $$ > /dev/null 2>&1
    fi
    exec "$BITCOIN_PORTABLE_DIR/$BITCOIN_PORTABLE_SUBDIR/bin/$CMD$BITCOIN_PORTABLE_EXE_EXTENSION" "$@"
}
