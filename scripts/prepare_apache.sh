#!/bin/bash -e

. .path2bins.sh

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

# Build APACHE

svn checkout http://svn.apache.org/repos/asf/httpd/httpd/branches/2.4.x httpd-2.4.x

pushd httpd-2.4.x

# wget http://www-eu.apache.org/dist//apr/apr-1.6.3.tar.gz
# tar xzf apr-1.6.3.tar.gz
# wget http://www-eu.apache.org/dist//apr/apr-util-1.6.1.tar.gz
# tar xzf apr-util-1.6.1.tar.gz

svn co http://svn.apache.org/repos/asf/apr/apr/trunk srclib/apr
svn co http://svn.apache.org/repos/asf/apr/apr-util/trunk srclib/apr-util

patch -p0 -i ${PATCH_PATH}
patch -p0 -i ${PATCH_PATH2}

./buildconf

CC=${AFL_GCC} ./configure --prefix=${AFL_HTTP_DIR}
make
make install
#PREFIX="/usr/local/apache_clean_test/" ./compile_dependencies_with_flags.sh

popd

zip -r afl-http.zip ${AFL_HTTP_DIR}

cp afl-http.zip ${STATIC_PATH}

# rm -f afl.zip
# rm -rf afl*

# out of TMP_DIR
popd

rmdir $TMP_DIR
