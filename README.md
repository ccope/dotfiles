dotfiles
===

My personal dotfiles

General Setup
====
```
git clone git@github.com:ccope/dotfiles.git ~/.dotfiles && cd ~/.dotfiles
./scripts/stow.sh
```
 - Scripts assume Ubuntu 16.04+
 - Scripts will install dependencies required for corresponding stowed configs or language tools
 - stow [folder] to symlink contents to ~/. Beware it doesn't overwrite existing files by default
 - Run language scripts (especially python) before running neovim for the first time

TODO
====
 - Make a non-root version of scripts
 - Add more gates around language plugins in vimrc
 - Add neovim gates to language scripts
