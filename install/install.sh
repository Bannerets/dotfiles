#!/usr/bin/env bash

_bakdir=~/.dotfiles.bak

echo "Home: $(echo ~)"

cd ~/dotfiles/

source ./install/utils.sh

if confirm "Link dotfiles?"; then
  # mkdir -p ~/.emacs.d
  mkdir -p ~/.config

  if confirm "Backup old dotfiles?"; then
    echo "Backup directory: $_bakdir"
    rm -rf $_bakdir
    mkdir -p "$_bakdir"
    mv ~/.inputrc "$_bakdir/inputrc"
    mv ~/.gitconfig "$_bakdir/gitconfig"
    # mv ~/.radare2rc "$_bakdir/radare2rc"
    # mv ~/.emacs.d/init.el "$_bakdir/init.el"
    mv ~/.vimrc "$_bakdir/vimrc"
    mv ~/.config/nvim "$_bakdir/nvim"
    mv ~/.config/fish "$_bakdir/fish"
    mv ~/.config/ranger "$_bakdir/ranger"
    mv ~/.config/kitty "$_bakdir/kitty"
    [ "$(ls -A $_bakdir)" ] || rm -r $_bakdir
  fi

  ln -s ~/dotfiles/inputrc ~/.inputrc
  ln -s ~/dotfiles/gitconfig ~/.gitconfig
  # ln -s ~/dotfiles/radare2rc ~/.radare2rc
  # ln -s ~/dotfiles/emacs/init.el ~/.emacs.d/init.el
  ln -s ~/dotfiles/vimrc ~/.vimrc
  ln -s ~/dotfiles/nvim ~/.config/nvim
  ln -s ~/dotfiles/fish ~/.config/fish
  ln -s ~/dotfiles/ranger ~/.config/ranger
  ln -s ~/dotfiles/kitty ~/.config/kitty
fi

mkdir -p ~/.local

# Lots of outdated stuff here

if [[ "$OSTYPE" == "darwin"* ]] && confirm "macOS detected. Run macos.sh?"; then
  ./install/macos.sh
fi

# if chk npm && confirm "Install npm packages?"; then
#   ./packages/npm.sh
# fi
#
# if chk opam && confirm "Install opam packages?"; then
#   ./packages/opam.sh
# fi
#
# if chk pip3 && confirm "Install pip packages?"; then
#   ./packages/python.sh
# fi
