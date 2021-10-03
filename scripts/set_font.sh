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

dotconfig="$HOME/.config"
parents="$HOME/.dotfiles"
config_writer="$parents/scripts/config_writer.sh"

CONFIGS=(
    "rofi/powermenu/config.rasi"   # rofi powermenu config
    "rofi/powermenu/confirm.rasi"  # rofi powermenu confirm
    "rofi/window/panel.rasi"       # rofi window 
    "rofi/drun/panel.rasi"         # rofi drun
    "kitty/kitty.conf"             # kitty
)

for config in ${CONFIGS[@]}; do
    eval "$config_writer $parents/$config $dotconfig/$config"
done
