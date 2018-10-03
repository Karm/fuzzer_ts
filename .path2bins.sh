#!/bin/bash

CC=`find -name afl-clang-fast`
CC=`realpath $CC`
CPP=`find -name afl-clang-fast++`
CPP=`realpath $CPP`
PATCH_PATH=`find -name afl_support.diff`
PATCH_PATH=`realpath ${PATCH_PATH}`
PATCH_PATH2=`find -name bug.diff`
PATCH_PATH2=`realpath ${PATCH_PATH2}`
TMP_DIR=`realpath "./tmp"`
AFL_HTTP_DIR="${TMP_DIR}/afl-http-prefix"

FUZZ_IN=`realpath ./testcases/apache2/`
FUZZ_OUT=`realpath .`/out
AFL_FUZZ=`find -name afl-fuzz`
AFL_FUZZ=`realpath $AFL_FUZZ`
HTTPD=`find ${AFL_HTTP_DIR} -name httpd`
HTTPD=`realpath ${HTTPD}`
# echo $HTTPD $AFL_FUZZ $FUZZ_IN $FUZZ_OUT

for VAR in $CC $CPP $PATCH_PATH $PATCH_PATH2; do
    if [ ! -f "${VAR}" ]; then
        echo "${VAR} is supposed do exist"
        exit 1
    fi
done
