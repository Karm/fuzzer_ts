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
cp  ${STATIC_PATH}/afl.zip .

unzip afl.zip

rm -f afl.zip

mv afl* ../fuzzers

# out of TMP_DIR
popd

rmdir $TMP_DIR
