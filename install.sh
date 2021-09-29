#!/bin/bash

cd ~/.dotfiles

ssh-keyscan github.com >> ~/.ssh/known_hosts

sudo pacman -Syu --noconfirm --needed  git yay gvim

yay -Sa --noedit --noconfirm --needed chruby ruby-install

# ruby-install ruby 2.7
source /usr/share/chruby/chruby.sh

chruby 2.7

gem install rake --no-document

rake install_dotfiles
rake update_SO

LIST="cronie sshd docker"

for serv in $LIST; do
  sudo systemctl start $srv
  sudo systemctl enable $srv
done
