#!/bin/bash

rm -rf "$HOME/.zprezto"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
git clone --recurse-submodules https://github.com/belak/prezto-contrib "$HOME/.zprezto/contrib"
chsh -s /bin/zsh
ln -fs "$HOME/dotfiles/zpreztorc-macos" "$HOME/.zpreztorc"
ln -fs "$HOME/dotfiles/zprofile" "$HOME/.zprofile"
ln -fs "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
ln -fs "$HOME/dotfiles/zlogin" "$HOME/.zlogin"
ln -fs "$HOME/dotfiles/zlogout" "$HOME/.zlogout"
ln -fs "$HOME/dotfiles/zshenv" "$HOME/.zshenv"
ln -fs "$HOME/dotfiles/fzfrc" "$HOME/.fzfrc"

mkdir -p "$HOME/.zprezto-contrib"
git clone https://github.com/agkozak/zsh-z.git "$HOME/.zprezto-contrib/zsh-z"

brew install git go zsh cloudfoundry/tap/bosh-cli direnv yarn wget tree tmux tcptraceroute jq fzf fd

/opt/homebrew/opt/fzf/install --all --key-bindings --completion --update-rc

git config --global user.email "github@michael-freedman.com"
git config --global user.name "Mik Freedman"
git config --global pull.rebase true
