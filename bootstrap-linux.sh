#!/bin/bash

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get --assume-yes install tmux git zsh silversearcher-ag net-tools unattended-upgrades software-properties-common python-software-properties
sudo add-apt-repository -yu ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get --assume-yes install neovim

chsh -s /usr/bin/zsh joe
git clone https://github.com/joefitzgerald/dotfiles.git
export GOVERSION="1.11.2"
if [[ "$OSTYPE" == darwin* ]]; then
  wget -O go.tar.gz "https://storage.googleapis.com/golang/go$GOVERSION.darwin-amd64.tar.gz"
else
  wget -O go.tar.gz "https://storage.googleapis.com/golang/go$GOVERSION.linux-amd64.tar.gz"
fi
sudo rm -rf /usr/local/go
sudo mkdir -p /usr/local/go
sudo chown joe:joe /usr/local/go
tar -C /usr/local -xzf go.tar.gz
rm -rf go.tar.gz
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
rm -rf ~/.vim/plugged
rm -rf ~/.zprezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
ln -fs "$HOME/dotfiles/vimrc" "$HOME/.vimrc"
ln -fs "$HOME/dotfiles/zpreztorc-linux" "$HOME/.zpreztorc"
ln -fs "$HOME/dotfiles/zprofile" "$HOME/.zprofile"
ln -fs "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
ln -fs "$HOME/dotfiles/zlogin" "$HOME/.zlogin"
ln -fs "$HOME/dotfiles/zlogout" "$HOME/.zlogout"
ln -fs "$HOME/dotfiles/zshenv" "$HOME/.zshenv"
mkdir -p "$HOME/go"
git config --global user.email "jfitzgerald@pivotal.io"
git config --global user.name "Joe Fitzgerald"
git config --global pull.rebase true
