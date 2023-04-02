#!/usr/bin/bash

rm ~/.bashrc -f
sudo pacman --needed -Suy \
  base-devel \
  make \
  yay \
  ansible \
  neovim \
  xclip \
  stow \
  tmux \
  fzf \
  curl \
  alacritty \
  ruby \
  nodejs \
  telegram-desktop \
  --noconfirm
yay -S asdf-vm slack-desktop google-chrome --noconfirm
make apply
