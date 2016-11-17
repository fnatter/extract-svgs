#!/bin/bash

#mkdir icons
#cd icons
csplit Edit_menu.svg '/^    </\?g/' '{*}'
mkdir svg
rm -f svg/*; i=0; while true; do f=$(printf "xx%02d" $((i+1))); test -f $f || break; cat xx00 $f xx80 > svg/$f.svg; i=$((i+2)); done

rm -f xx*

for i in svg/xx*.svg; do t=$(grep '^       inkscape:export-filename=' $i | perl -pe 's,.*\\,,; s,.png.*,.svg,') && mv $i svg/$t; done
