#!/bin/sh

# arg 1 is file or directory to back up
function backup_if_exists () {
  if [ -s "$1" ]; then
    echo ">>>> backing up $1 to $1.bak"
    cp -r "$1" "$1.bak"
  fi

}

# arg 1 is the source file, arg 2 is the link to be created
# (macOS ln doesn't have -b)
function link_with_backup () {
  backup_if_exists "$2"
  ln -sfv "$1" "$2"

}
