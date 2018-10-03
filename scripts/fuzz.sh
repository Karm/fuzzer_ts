#!/bin/bash

. ./.path2bins.sh

killall -9 httpd

sed 's/Listen 80$/Listen 8085/' ${HTTPD_CONF} -i

screen -dm -S fuzzing_screen ${AFL_FUZZ_SCRIPT}

UC=0
while [ ${UC} -le 5 ];
do
    sleep 1;
    if [ -f ${FUZZ_STATS} ]; then
        UC=`grep 'unique_crashes' $FUZZ_STATS | cut -d: -f2 | sed 's/[[:space:]]//g'`
    fi
done

screen -X -S fuzzing_screen quit

