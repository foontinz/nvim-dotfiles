#!/bin/bash

ROOT_PATH="$HOME/dev/personal/dotfiles"

# install oh-my-zsh (unattended)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# copy shell configuration
cp "$ROOT_PATH/cmd/zsh.bash" "$HOME/.zshrc"
cp "$ROOT_PATH/cmd/zprofile.zsh" "$HOME/.zprofile"
