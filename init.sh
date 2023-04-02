#!/usr/bin/bash

rm ~/.bashrc -f
sudo pacman -Suy \
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
  --noconfirm
sudo pamac build asdf-vm --no-confirm
