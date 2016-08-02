#!/bin/sh

if [ ! -d ~/dotfiles ]; then
  echo "cloning dotfiles repo to ~/dotfiles..."
  git clone https://github.com/brettferdosi/dotfiles.git ~/dotfiles
else
  echo "pulling updates to ~/dotfiles..."
  cd ~/dotfiles
  git pull
  cd -
fi

echo "running dotfiles installer..."
sh ~/dotfiles/install.sh
