#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config
polybar --config=~/.dotfiles/polybar/config left 2>&1 &
polybar --config=~/.dotfiles/polybar/config right 2>&1 &
polybar --config=~/.dotfiles/polybar/config spotify 2>&1 &

echo "Polybar launched..."
