#!/usr/bin/env bash

DIR="`realpath $0 | xargs dirname`"
BASEDIR=`realpath $DIR/../`

pushd $BASEDIR

mkdir -pv ${BASEDIR}/Gen/Rmd

R -e "rmarkdown::render('`echo Src/TextMining.Rmd`', output_file='`echo ${BASEDIR}/Gen/TextMining.html`')"

popd
