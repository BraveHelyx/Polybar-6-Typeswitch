#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bottom bar across all monitors and top bar on primary
if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d " " -f 1); do
        MONITOR=$m polybar -c ~/.config/polybar/config-bot.ini bottom &
    done
    polybar -c ~/.config/polybar/config.ini main &
else
    polybar -c ~/.config/polybar/config.ini main &
    polybar -c ~/.config/polybar/config-bot.ini bottom &   
fi
