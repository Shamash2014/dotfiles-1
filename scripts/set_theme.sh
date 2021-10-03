#!/bin/bash

#####  UNDER CONSTRUCTION ######

options="Themeing options!\n  1. Nord"
n=1

while
    echo -e $options
    read input
    [[ -n ${input//[1-$n]/} ]]
do echo "Invalid number!"; done

case $input in
    "1")
	echo "nord" > ~/.controllers/theme
	;;
esac
