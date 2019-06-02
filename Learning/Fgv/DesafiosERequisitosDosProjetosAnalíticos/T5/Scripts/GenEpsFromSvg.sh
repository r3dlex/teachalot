#!/bin/bash

IMAGE_FOLDER="Src/Image"
OUTPUT_FOLDER="Gen/Image"

mkdir -p ${OUTPUT_FOLDER}
for x in `ls ${IMAGE_FOLDER}/*.svg`; do
  fname=`basename -s .svg $x`
  echo "Running:   inkscape -f $x -e ${OUTPUT_FOLDER}/${fname}.png --export-dpi=300"
  inkscape -f $x -e ${OUTPUT_FOLDER}/${fname}.png --export-dpi=300
done
