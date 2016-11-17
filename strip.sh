#!/bin/bash

(
cd svg
mkdir stripped
for i in *.svg; do scour -i $i -o stripped/$i --enable-id-stripping --enable-comment-stripping --shorten-ids; done
)
