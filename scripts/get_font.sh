#!/bin/bash

font_controller="$HOME/.controllers/font"
while read line; do
    font=$line
done < $font_controller
echo $font
