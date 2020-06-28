#!/bin/sh

DIR="`cd "\`dirname "$0"\`" && pwd -P`"

echo ">>>> dotfiles start"

echo ">>>> creating symbolic links from ~ to $DIR..."
ln -sfv "$DIR/.shell_env" ~
ln -sfv "$DIR/.shell_aliases" ~
ln -sfv "$DIR/.bash_profile" ~
ln -sfv "$DIR/.bashrc" ~
ln -sfv "$DIR/.zshrc" ~
ln -sfv "$DIR/.vimrc" ~
ln -sfv "$DIR/.tmux.conf" ~
ln -sfv "$DIR/.gitconfig" ~
ln -sfv "$DIR/.gitignore" ~

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  echo ">>>> cloning vundle repo to ~/.vim/bundle/Vundle.vim..."
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo ">>>> installing Vundle plugins..."
# input tty so vim doesn't complain
vim +PluginInstall +qall </dev/tty

echo ">>>> dotfiles done"
