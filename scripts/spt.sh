#!/bin/bash

cmd="spotifyd --no-daemon"
program="spotifyd"
pgrep="pgrep $program"
pgo=$(eval $pgrep)

if [[ $pgo == "" ]]; then
    eval $cmd &
fi
