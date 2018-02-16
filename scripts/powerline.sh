#!/bin/bash
if command -v apt &>/dev/null; then
	sudo apt install python3-pygit2 fonts-powerline
fi
pip3 install --user git+git://github.com/powerline/powerline
