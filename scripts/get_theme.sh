#!/bin/bash

theme_controller="$HOME/.dotfiles/controllers/theme"
while read line; do
    theme=$line
done < $theme_controller
#echo $theme
echo $theme
