#!/bin/bash

DIR="`cd "\`dirname "$0"\`" && pwd -P`"

echo ">>>> macOS start"

if [ $(uname) != "Darwin" ]; then
  echo ">>>> you probably don't want to run this"
  echo ">>>> macOS end"
  exit 1
fi

# hush login messages
echo ">>>> touch ~/.hushlogin"
touch ~/.hushlogin

# set system preferences
echo ">>>> configuring system preferences"
sh "$DIR/defaults.sh"

# load terminal profile
echo ">>>> setting default terminal profile... quit Terminal.app for effect"
open "$DIR/brett.terminal"
defaults write com.apple.terminal "Default Window Settings" "brett"
defaults write com.apple.terminal "Startup Window Settings" "brett"

# download packages

# check for developer tools and install if necessary
xcode-select -p > /dev/null
RET=$?
if [ $RET -ne 0 ]; then
  echo ">>>> installing xcode developer tools"
  xcode-select --install
fi

# check for homebrew and install if necessary
which brew > /dev/null
RET=$?
if [ $RET -ne 0 ]; then
  echo ">>>> installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# update to latest version of homebrew
echo ">>>> brew update"
brew update -v

# install bundle packages
brew bundle check --file="$DIR/Brewfile" > /dev/null
RET=$?
if [ $RET -ne 0 ]; then
  echo ">>>> brew bundle install"
  brew bundle install -v --no-lock --file="$DIR/Brewfile"
fi

# upgrade installed brews
echo ">>>> upgrade installed brews"
brew upgrade -v

# upgrade installed casks
echo ">>>> upgrade installed casks"
brew cask upgrade -v

# upgrade installed mas apps
echo ">>>> upgrade installed App Store apps"
mas upgrade

# clean up unnecessary files
echo ">>>> brew cleanup"
brew cleanup -v -s

# check for problems
echo ">>>> brew doctor"
brew doctor -v

echo ">>>> macOS end"
