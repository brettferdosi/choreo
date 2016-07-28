#!/bin/sh

if [ ! -d ~/dotfiles ]; then
  git clone https://github.com/brettferdosi/dotfiles.git ~/dotfiles
fi
sh ~/dotfiles/install.sh
