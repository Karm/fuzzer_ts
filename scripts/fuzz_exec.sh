#!/bin/bash -e
. .path2bins.sh
#./fuzzers/afl-2.52b/afl-fuzz -i testcases/apache2/ -o out -m 1000 -t 1000000 ./tmp/afl-http-prefix/bin/httpd -X
${AFL_FUZZ} -i ${FUZZ_IN} -o ${FUZZ_OUT} -m 1000 -t 1000000 ${HTTPD} -X
