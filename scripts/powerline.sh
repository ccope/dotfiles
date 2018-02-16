#!/bin/bash
if command -v apt &>/dev/null; then
	sudo apt install -y python3-pygit2 fonts-powerline
fi
pip3 install --user git+git://github.com/powerline/powerline
