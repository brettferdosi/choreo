#!/bin/sh

DIR=`cd "\`dirname "$0"\`" && pwd -P`

source "$DIR/../lib.sh"

echo ">>>> dotfiles start"

echo ">>>> creating symbolic links from ~ to $DIR..."
link_with_backup "$DIR/.shell_env" ~/.shell_env
link_with_backup "$DIR/.shell_aliases" ~/.shell_aliases
link_with_backup "$DIR/.bash_profile" ~/.bash_profile
link_with_backup "$DIR/.bashrc" ~/.bashrc
link_with_backup "$DIR/.zshrc" ~/.zshrc
link_with_backup "$DIR/.vimrc" ~/.vimrc
link_with_backup "$DIR/.tmux.conf" ~/.tmux.conf
link_with_backup "$DIR/.gitconfig" ~/.gitconfig
link_with_backup "$DIR/.gitignore" ~/.gitignore

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  echo ">>>> cloning vundle repo to ~/.vim/bundle/Vundle.vim..."
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo ">>>> installing Vundle plugins..."
# input tty so vim doesn't complain
vim +PluginInstall +qall </dev/tty

echo ">>>> dotfiles done"
