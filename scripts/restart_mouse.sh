#!/bin/zsh
sudo modprobe -r hid_logitech_hidpp hid_logitech_dj
sleep 0.5
sudo modprobe hid_logitech_hidpp
sudo modprobe hid_logitech_dj
