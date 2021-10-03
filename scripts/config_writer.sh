#!/bin/bash

fontg="<font>"
font=$(~/.dotfiles/scripts/get_font.sh)

parent=$1
dest=$2
echo "" > $dest

while read l; do
    if [[ $l = "" ]]; then
	line=""
    else
	for word in $l; do
	    if [[ $word == $fontg ]]; then
		line="${l/<font>/$font}"
	    else
		line=$l 
	    fi
	done
    fi
    printf "$line\n" >> $dest
done < $parent
