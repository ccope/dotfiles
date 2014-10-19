dotfiles
===

My personal dotfiles

General Setup
====
 - Install GNU Stow
 - Clone repo && cd to repo root
 - stow [folder] to symlink contents to ~/. Beware it doesn't overwrite existing files by default
 - Install deps for powerline (see instructions in github repo). Don't forget pygit2!
 - pip install --user git+git://github.com/Lokaltog/powerline

Vim Setup
====
 - Follow General Setup
 - hg clone https://bitbucket.org/ludovicchabant/vim-lawrencium into ~/.vim/bundle/
 - Download Vundle: https://github.com/gmarik/Vundle.vim#quick-start
 - Open vim, run ```:PluginInstall```
