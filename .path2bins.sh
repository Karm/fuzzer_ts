#!/bin/bash

CC=`find -name afl-clang-fast`
CC=`realpath $CC`
CPP=`find -name afl-clang-fast++`
CPP=`realpath $CPP`
#PATCH_PATH=`find -name apatching_apache_for_AFL_fuzzing.diff`
PATCH_PATH=`find -name afl_support.diff`
PATCH_PATH=`realpath ${PATCH_PATH}`
#PATCH_PATH2=`find -name patch2.diff`
PATCH_PATH2=`find -name bug.diff`
PATCH_PATH2=`realpath ${PATCH_PATH2}`
TMP_DIR=`realpath "./tmp"`
AFL_HTTP_DIR="${TMP_DIR}/afl-http-prefix"

for VAR in $CC $CPP $PATCH_PATH $PATCH_PATH2; do
    if [ ! -f "${VAR}" ]; then
        echo "${VAR} is supposed do exist"
        exit 1
    fi
done
