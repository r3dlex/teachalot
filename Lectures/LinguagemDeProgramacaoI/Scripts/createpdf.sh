#!/bin/bash

echo "Creating presentation"
pdflatex -shell-escape -interaction=nonstopmode presentation.tex
bibtex *.aux
pdflatex -shell-escape -interaction=nonstopmode presentation.tex

dir_name=`pwd | xargs basename`
echo "dir: ${dir_name}"
mv -v presentation.pdf ../Gen/${dir_name}.pdf
