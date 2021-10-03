#!/bin/bash

#####  UNDER CONSTRUCTION ######

current_font=$(~/.dotfiles/scripts/get_font.sh)
echo "Current Font : $current_font"

options="Font options!\n  1. Victor\n  2. FiraCode\n  3. SF\n  4. JetBrains\n  5. CaskaydiaCove"
n=5

while
    echo -e $options
    read input
    [[ -n ${input//[1-$n]/} ]]
do echo "Invalid number!"; done

case $input in

    "1")
	font="VictorMono Nerd Font Mono"
	echo $font > ~/.dotfiles/controllers/font
	;;

    "2")
	font="FiraCode Nerd Font Mono"
	echo $font > ~/.dotfiles/controllers/font
	;;

    "3")
	font="SFMono Nerd Font Mono"
	echo $font > ~/.dotfiles/controllers/font
	;;

    "4")
	font="JetBrainsMono Nerd Font Mono"
	echo $font > ~/.dotfiles/controllers/font
	;;

    "5")
	font="CaskaydiaCove Nerd Font Mono"
	echo $font > ~/.dotfiles/controllers/font
	;;
    
esac
echo "New font : "$font

# configs to write

dots="$HOME/.dotfiles"
scripts="$dots/scripts"
parents="$dots/controllers/parent_configs"

eval "$scripts/config_writer.sh $parents/kitty/kitty.conf $dots/kitty/kitty.conf"
