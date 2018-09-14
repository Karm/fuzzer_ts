#!/bin/bash

AFL_GCC=`find -name afl-gcc`
AFL_GCC=`realpath $AFL_GCC`
PATCH_PATH=`find -name apatching_apache_for_AFL_fuzzing.diff`
PATCH_PATH=`realpath ${PATCH_PATH}`
PATCH_PATH2=`find -name patch2.diff`
PATCH_PATH2=`realpath ${PATCH_PATH2}`
TMP_DIR=`realpath "./tmp"`
AFL_HTTP_DIR="${TMP_DIR}/afl-http-prefix"

for VAR in $AFL_GCC $PATCH_PATH $PATCH_PATH2; do
    if [ ! -f "${VAR}" ]; then
        echo "${VAR} is supposed do exist"
        exit 1
    fi
done
