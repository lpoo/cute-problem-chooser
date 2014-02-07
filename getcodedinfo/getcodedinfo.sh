#!/bin/bash

outfile=../sif.decoder
rm -f ../sif.decoder
for problem in $(awk '{print $1}' ../sif.url)
do
  echo -n "$problem: Decoding... "
  make -B -s PROBNAME=$problem
  echo -n "Done. Generating info... "
  ./main >> $outfile
  echo "Done."
done

make clean
