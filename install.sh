#!/bin/sh

# install things by cloning the repo then running this script

DIR="`cd "\`dirname "$0"\`" && pwd -P`"

if [ "$#" -eq "0" ]; then
  echo "run with options: cli, macOS"
  exit 1
fi

while [ "$#" -gt "0" ]
do
case "$1" in
  cli)
    /bin/sh "$DIR/cli/cli.sh"
    ;;
  macOS)
    /bin/bash "$DIR/macOS/macOS.sh"
    ;;
  *)
    echo "unknown option $1"
esac
shift
done
