#!/bin/bash

theme=$(~/.dotfiles/scripts/get_theme.sh)
DIR=~/.dotfiles/wallpapers/$theme

num=$(ls $DIR | wc -l)
index=$(((1 + $RANDOM % $num)-1))
files=(
    "$DIR"/*.png
    "$DIR"/*.jpg
)
filename=${files[$index]}
echo $filename
feh --bg-fill $filename
