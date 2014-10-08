#!/bin/bash

#TODO check if inskscape is installed and stuff
for x in `ls Svg/*`; do
  fname=`basename -s .svg $x`
  echo "Running:   inkscape -f $x -e Gen/Image/${fname}.eps --export-dpi=300"
  inkscape -f $x -e Gen/Image/${fname}.eps --export-dpi=300
  #inkscape -w 1024 -f $x -e Gen/Image/${fname}.eps
done
