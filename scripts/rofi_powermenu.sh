#!/usr/bin/env bash

dir="$HOME/.config/rofi/powermenu"
config="config.rasi"
confirm="confirm.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -config $dir/$config"

# Options
shutdown=" Shutdown"
reboot="⭘ Reboot"
suspend="⏼ Suspend"
logout="⏽ Logout"

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-config $dir/$confirm
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 2)"
case $chosen in
    
    # case shutdown
    $shutdown)
	ans=$(confirm_exit &)
	if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
	    systemctl poweroff
	elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
	    exit 0
	fi
	;;
    
    #case reboot
    $reboot)
	ans=$(confirm_exit &)
	if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
	    systemctl reboot
	elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
	    exit 0
	fi
	;;

    #case suspend
    $suspend)
	ans=$(confirm_exit &)
	if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
	    systemctl suspend 
	elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
	    exit 0
	fi
	;;

    #case logout
    $logout)
	ans=$(confirm_exit &)
	if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
	    killall awesome
	elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
	    exit 0
	fi
	;;
    
esac
