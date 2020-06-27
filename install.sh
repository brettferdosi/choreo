#!/bin/sh

DIR="`cd "\`dirname "$0"\`" && pwd -P`"

# TODO add macOS, firefox stuff and arg parsing

echo "creating symbolic links from ~ to $DIR..."
ln -sfv "$DIR/cli/.shell_env" ~
ln -sfv "$DIR/cli/.shell_aliases" ~
ln -sfv "$DIR/cli/.bash_profile" ~
ln -sfv "$DIR/cli/.bashrc" ~
ln -sfv "$DIR/cli/.zshrc" ~
ln -sfv "$DIR/cli/.vimrc" ~
ln -sfv "$DIR/cli/.tmux.conf" ~
ln -sfv "$DIR/cli/.gitconfig" ~
ln -sfv "$DIR/cli/.gitignore" ~

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  echo "cloning vundle repo to ~/.vim/bundle/Vundle.vim..."
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo "installing Vundle plugins..."
# input tty so vim doesn't complain
vim +PluginInstall +qall </dev/tty

echo "done"
