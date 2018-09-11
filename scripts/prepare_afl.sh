#!/bin/bash -e

if [ ! $# -eq 1 ]; then
    echo "PATH to STATIC is required"
    exit 1
fi

STATIC_PATH=$1

if [ ! -d $STATIC_PATH ]; then
    echo "${STATIC_PATH} is supposed do exist"
    exit 1
fi

TMP_DIR="./tmp"

if [ -d $TMP_DIR ]; then
    echo "${TMP_DIR} is not supposed do exist"
    exit 1
fi

mkdir $TMP_DIR

pushd $TMP_DIR

# Build AFL
wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz

tar xzf afl-latest.tgz

rm -f afl-latest.tgz

pushd afl*
make
popd

zip -r afl.zip afl*

cp afl.zip ${STATIC_PATH}

rm -f afl.zip
rm -rf afl*

# out of TMP_DIR
popd

rmdir $TMP_DIR
