dotfiles
===

My personal dotfiles

General Setup
====
 - Install GNU Stow
 - Clone repo && cd to repo root
 - stow [folder] to symlink contents to ~/. Beware it doesn't overwrite existing files by default
 - Setup neovim pip modules before running neovim for the first time

Python
====
 - pyenv
 - Pipenv
 - jedi

Ruby
====
 - rbenv

Vim Setup
====
 - Follow General Setup
 - Follow vim-plug setup
 - Open vim, run ```:PlugInstall```

nvim setup
===
 - pip install --user neovim
 - pip3 install --user neovim
 - Follow vim setup
