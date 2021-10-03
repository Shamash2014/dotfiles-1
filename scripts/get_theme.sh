#!/bin/bash

theme_controller="$HOME/.controllers/theme"
while read line; do
    theme=$line
done < $theme_controller
echo $theme
