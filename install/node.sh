#!/usr/bin/env bash

cd ~ || exit 1

if ! command -v n &> /dev/null; then
  echo "Intalling n..." \
    && git clone https://github.com/tj/n n-git \
    && cd n-git \
    && sudo PREFIX=/usr/local make install \
    && cd ~
else
  echo "n is already installed."
fi

if ! command -v node &> /dev/null; then
  echo "Intalling Node.js..."
  sudo n latest
else
  echo "Node.js is already installed."
fi

if command -v npm &> /dev/null; then
  echo "Previous npm prefix: $(npm config get prefix)"
  npm config set prefix ~/.local
  echo "New npm prefix: $(npm config get prefix)"
else
  echo "npm not found!"
  exit 1
fi
