#!/bin/bash

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get --assume-yes install tmux git zsh silversearcher-ag net-tools unattended-upgrades software-properties-common fzf direnv jq bat
sudo apt-get update

# make bat work
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

chsh -s /usr/bin/zsh $USER
# export GOVERSION="1.11.2"
# if [[ "$OSTYPE" == darwin* ]]; then
#   wget -O go.tar.gz "https://storage.googleapis.com/golang/go$GOVERSION.darwin-amd64.tar.gz"
# else
#   wget -O go.tar.gz "https://storage.googleapis.com/golang/go$GOVERSION.linux-amd64.tar.gz"
# fi
# sudo rm -rf /usr/local/go
# sudo mkdir -p /usr/local/go
# sudo chown $USER:$USER /usr/local/go
# tar -C /usr/local -xzf go.tar.gz
# rm -rf go.tar.gz
mkdir -p "$HOME/.zprezto-contrib"
git clone https://github.com/agkozak/zsh-z.git "$HOME/.zprezto-contrib/zsh-z"

rm -rf ~/.zprezto

git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
ln -fs "$HOME/dotfiles/zpreztorc-linux" "$HOME/.zpreztorc"
ln -fs "$HOME/dotfiles/zprofile" "$HOME/.zprofile"
ln -fs "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
ln -fs "$HOME/dotfiles/zlogin" "$HOME/.zlogin"
ln -fs "$HOME/dotfiles/zlogout" "$HOME/.zlogout"
ln -fs "$HOME/dotfiles/zshenv" "$HOME/.zshenv"
ln -fs "$HOME/dotfiles/gitconfig" "$HOME/.gitconfig"
mkdir -p "$HOME/go"
git config --global user.email "github@michael-freedman.com"
git config --global user.name "Mik Freedman"
git config --global pull.rebase true
