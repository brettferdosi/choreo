#!/bin/sh

if [ ! -d ~/dotfiles ]; then
  echo "cloning dotfiles repo to ~/dotfiles..."
  git clone https://github.com/brettferdosi/dotfiles.git ~/dotfiles
fi

echo "running dotfiles installer..."
sh ~/dotfiles/install.sh
