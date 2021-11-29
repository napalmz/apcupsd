#!/bin/bash

TODAY=$(date +%s)
RUNTIME=$(apcaccess | grep "DATE\ \ \ " |awk '{print "\""$3" "$4"\""}' | xargs date +%s -d)
DIFF=$(expr $TODAY - $RUNTIME)
# Optional parameter, default 120sec
LIMIT=${1:-120}

#echo $DIFF

if [ $DIFF -ge $LIMIT ];
then
  exit 1
else
  exit 0
fi