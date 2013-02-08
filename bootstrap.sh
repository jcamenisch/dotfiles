#!/bin/bash

# With thanks to Mathias Bynens. https://github.com/mathiasbynens/dotfiles/blob/master/bootstrap.sh

cd "$(dirname $0)"

git pull
git submodule init
git submodule update

function doIt() {
  rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
  sh ./.vim/bootstrap.sh
  [ `uname` = "Darwin" ] && [ -f macos_tweaks.sh ] && sh macos_tweaks.sh
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi

unset doIt

cd -

source ~/.profile
