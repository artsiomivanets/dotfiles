#!/usr/bin/bash

rm ~/.bashrc -f
sudo pacman -Suy \
  make \
  ansible \
  neovim \
  xclip \
  stow \
  tmux \
  fzf \
  alacritty \
  --noconfirm
