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
  ripgrep \
  fd \
  zip \
  unzip \
  npm \
  yarn \
  tar \
  postgresql \
  telegram-desktop \
  bash-completion \
  --noconfirm
yay -S asdf-vm slack-desktop google-chrome --noconfirm
make apply
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
