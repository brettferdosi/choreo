#!/bin/sh

DIR="`cd "\`dirname "$0"\`" && pwd -P`"

echo "creating symbolic links from ~ to $DIR..."
ln -sfv "$DIR/.bash_profile" ~
ln -sfv "$DIR/.bashrc" ~
ln -sfv "$DIR/.vimrc" ~
ln -sfv "$DIR/.tmux.conf" ~

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  echo "cloning vundle repo to ~/.vim/bundle/Vundle.vim..."
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo "installing Vundle plugins..."
# input tty so vim doesn't complain
vim +PluginInstall +qall </dev/tty

echo "done"
