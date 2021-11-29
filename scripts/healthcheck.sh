#!/bin/bash

TODAY=$(date +%s)
RUNTIME=$(apcaccess | grep "DATE\ \ \ " |awk '{print "\""$3" "$4"\""}' | xargs date +%s -d)
DIFF=$(expr $TODAY - $RUNTIME)
LIMIT=70

#echo $DIFF

if [ $DIFF -ge $LIMIT ];
then
  exit 1
else
  exit 0
fi