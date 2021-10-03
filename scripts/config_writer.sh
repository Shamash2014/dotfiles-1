#!/bin/bash

###### ONLY DOES FONTS CURRENTLY #####

fontg="<font>"
font=$(~/.dotfiles/scripts/get_font.sh)

parent=$1
dest=$2

cat $parent | awk -v fontg="$fontg" -v font="$font" '{
     gsub(fontg, font)
     print 
}' > $dest

