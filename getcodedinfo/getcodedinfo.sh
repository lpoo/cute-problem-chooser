#!/bin/bash

outfile=../sif.dcd
rm -f $outfile
for problem in $(awk '{print $1}' ../sif.bsc)
do
  echo -n "$problem: Decoding... "
  make -B -s PROBNAME=$problem
  echo -n "Done. Generating info... "
  ./main >> $outfile
  echo "Done."
done

make clean
