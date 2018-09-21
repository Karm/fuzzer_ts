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

# pushd srclib/apr
# touch libtoolT
# CC=${CC} ./configure --prefix=${AFL_HTTP_DIR} --with-libxml2
# popd

CC=${CC} CXX=${CPP} ./configure --prefix=${AFL_HTTP_DIR} --with-libxml2
#CC=${CC} ./configure --prefix=${AFL_HTTP_DIR} --with-libxml2
make
make install

popd

zip -r afl-http.zip ${AFL_HTTP_DIR}

cp afl-http.zip ${STATIC_PATH}

# rm -f afl.zip
# rm -rf afl*

# out of TMP_DIR
popd

rmdir $TMP_DIR
