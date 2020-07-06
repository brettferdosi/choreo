#!/bin/sh

DIR="`cd "\`dirname "$0"\`" && pwd -P`"

if [ "$#" -eq "0" ]; then
  echo ">>>> run with options: dotfiles, macOS, firefox"
  exit 1
fi

while [ "$#" -gt "0" ]
do
case "$1" in
  dotfiles)
    DOTFILES=1
    ;;
  macOS)
    MACOS=1
    ;;
  firefox)
    FIREFOX=1
    ;;
  *)
    echo ">>>> unknown option $1"
esac
shift
done

if [ -n "$DOTFILES" ]; then
  /bin/sh "$DIR/dotfiles/dotfiles.sh"
fi

if [ -n "$MACOS" ]; then
  /bin/sh "$DIR/macOS/macOS.sh"
fi

if [ -n "$FIREFOX" ]; then
  /bin/sh "$DIR/firefox/firefox.sh"
fi
