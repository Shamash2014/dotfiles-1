#!/bin/bash

PROGRAMS=(
    "~/.dotfiles/scripts/fehbg.sh"
    "redshift"
    # "kmix"
    # "nm-applet"
    "~/.dotfiles/scripts/spt.sh"
    # "dropbox"
    "pkttyagent"
    "picom"
)

for program in ${PROGRAMS[@]}; do
    length=${#program}
    name=""
    pgrep="pgrep $program"
    if [[ ${program:length-3:length-1} != ".sh" ]]; then
	pgo=$(eval $pgrep)
	if [[ $pgo == "" ]]; then
	    eval $program &
	fi
    else
	eval $program &
    fi
done
