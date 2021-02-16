#!/bin/bash

rm -rf "$HOME/.zprezto"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
chsh -s /bin/zsh
ln -fs "$HOME/dotfiles/zpreztorc-macos" "$HOME/.zpreztorc"
ln -fs "$HOME/dotfiles/zprofile" "$HOME/.zprofile"
ln -fs "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
ln -fs "$HOME/dotfiles/zlogin" "$HOME/.zlogin"
ln -fs "$HOME/dotfiles/zlogout" "$HOME/.zlogout"
ln -fs "$HOME/dotfiles/zshenv" "$HOME/.zshenv"
brew install git go zsh cloudfoundry/tap/bosh-cli direnv yarn wget tree tmux tcptraceroute jq
git config --global user.email "github@michael-freedman.com"
git config --global user.name "Mik Freedman"
git config --global pull.rebase true
