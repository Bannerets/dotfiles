#!/usr/bin/env bash

BAKDIR=~/.dotfiles.bak

echo "Home: $(echo ~)"

source ./utils.sh

if confirm "Link dotfiles?"; then
  if confirm "Backup old dotfiles?"; then
    echo "Backup directory: $BAKDIR"
    rm -rf $BAKDIR
    mkdir -p "$BAKDIR"
    mv ~/.bash_profile "$BAKDIR/bash_profile"
    mv ~/.gitconfig "$BAKDIR/gitconfig"
    mv ~/.radare2rc "$BAKDIR/radare2rc"
    [ "$(ls -A $BAKDIR)" ] || rm -r $BAKDIR
  fi

  ln -s ~/dotfiles/bash_profile ~/.bash_profile
  ln -s ~/dotfiles/gitconfig ~/.gitconfig
  ln -s ~/dotfiles/radare2rc ~/.radare2rc
fi

mkdir -p ~/.local

if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "macOS detected."
  source ./macos.sh
fi

if confirm "Install Node.js?"; then
  ./node.sh
fi
