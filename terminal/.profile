# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# PATH additions
export GOPATH="/home/cam/work/dropbox/repos/go-server"
export PATH=/sbin:/usr/sbin:$GOPATH/bin:$PATH
if [ -d "$HOME/.local/bin" ] ; then
        PATH="$HOME/.local/bin:$PATH"
fi

export RBENV="$HOME/.rbenv/bin"
if [ -d $RBENV ]; then
	export PATH="$RBENV:$PATH"
fi

if [ -d "$HOME/.arc_install" ]; then
	export PATH="$PATH:$HOME/.arc_install/arcanist/bin"
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

unset RBENV
