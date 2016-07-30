#!/bin/sh

DIR="$(cd "$(dirname "$0")" && pwd -P)"

ln -sfv "$DIR/.bash_profile" ~
ln -sfv "$DIR/.bashrc" ~
ln -sfv "$DIR/.vimrc" ~
ln -sfv "$DIR/.tmux.conf" ~
