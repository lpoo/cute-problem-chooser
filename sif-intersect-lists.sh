#!/bin/bash

[ $# -lt 2 ] && echo "Need at least two lists as arguments" && exit 1
lists=$*
for list in $lists
do
  [ ! -f $list ] && echo "$list is not a file/does not exists" && exit 1
done

mainlist=$1
shift

for problem in $(cat $mainlist)
do
  intersect=true
  for list in $*
  do
    g=$(grep -w $problem $list)
    [ -z "$g" ] && intersect=false && break
  done
  [ $intersect == "true" ] && echo $problem
done


