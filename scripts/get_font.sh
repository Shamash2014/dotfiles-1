#!/bin/bash

font_controller="$HOME/.dotfiles/controllers/font"
while read line; do
    font=$line
done < $font_controller
#echo $theme
echo $font
