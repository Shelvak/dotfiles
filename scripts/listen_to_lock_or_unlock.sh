#!/bin/bash
dbus-monitor --session "type='signal',interface='org.gnome.ScreenSaver'" | while read x; do
    case "$x" in
        *"boolean true"*) # Lock
            /home/rotsen/.dotfiles/scripts/toggle_lights.rb 'Off' # turn off smart-lights
            sleep 1
            xset dpms force off;; # Turn of monitors Gnome-bug
        *"boolean false"*) # Unlock
            sleep 1 # after suspend have to wait for network
            /home/rotsen/.dotfiles/scripts/toggle_lights.rb 'On' # turn on smart-lights
            sleep 1
            /home/rotsen/.dotfiles/scripts/night-light ;; # Change temperature of monitor depending on the daily time
    esac
done
