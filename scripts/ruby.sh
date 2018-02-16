#!/bin/bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
git clone https://github.com/garnieretienne/rvm-download.git ~/.rbenv/plugins/rvm-download
export RBENV="$HOME/.rbenv/bin"
export PATH="$RBENV:$PATH"
eval "$(rbenv init -)"
rbenv download 2.4.1
rbenv global 2.4.1
sudo apt install -y libgmp-dev
rbenv exec gem install neovim
