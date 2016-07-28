#!/bin/sh

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sfv "$DIR/.bash_profile" ~
ln -sfv "$DIR/.bashrc" ~
ln -sfv "$DIR/.vimrc" ~
ln -sfv "$DIR/.tmux.conf" ~
