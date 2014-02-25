#!/bin/bash

[ $# -lt 1 ] && echo "Need list as argument" && exit 1
list=$1
[ ! -f $list ] && echo "$list is not a file/does not exists" && exit 1

[ -z "$MASTSIF" ] && echo "$MASTSIF not set. export MASTSIF=/path/to/sif" \
  && exit 1

for problem in $(ls $MASTSIF/*.SIF)
do
  problem=${problem//$MASTSIF\//}
  problem=${problem//.SIF/}
  g=$(grep -w $problem $list)
  [ -z "$g" ] && echo $problem
done


