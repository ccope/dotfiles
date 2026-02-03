# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# PATH additions
if [ -z ${PATH_CONFIGURED+x} ]; then
	if [ -d "$HOME/.yarn/bin" ] ; then
	    PATH="$PATH:$HOME/.yarn/bin"
	fi

	export RBENV="$HOME/.rbenv/bin"
	if [[ -d $RBENV && "$PATH" != [:^]*"$RBENV"[:$]* ]]; then
		export PATH="$PATH:$RBENV"
	fi
	unset RBENV

	export POETRY="$HOME/.poetry/bin"
	if [[ -d $POETRY && "$PATH" != [:^]*"$POETRY"[:$]* ]]; then
		export PATH="$PATH:$POETRY"
	fi
	unset POETRY

	export PYENV_ROOT="$HOME/.pyenv/bin"
	if [[ -d $PYENV_ROOT && "$PATH" != [:^]*"$PYENV_ROOT"[:$]* ]]; then
		export PATH="$PATH:$PYENV_ROOT"
	fi
	unset PYENV_ROOT

	if [[ -d "$HOME/projects/go/bin" && "$PATH" != [:^]*"$HOME/projects/go/bin"[:$]* ]]; then
		PATH="$PATH:$HOME/projects/go/bin"
	fi

	if [[ -d "$HOME/.cargo/bin" && "$PATH" != [:^]*"$HOME/cargo/bin"[:$]* ]]; then
		PATH="$PATH:$HOME/.cargo/bin"
	fi

	if [[ -d "$HOME/.local/bin" && "$PATH" != [:^]*"$HOME/.local/bin"[:$]* ]]; then
		PATH="$PATH:$HOME/.local/bin"
	fi

	#if [[ -d "$HOME/bin" && "$PATH" != [:^]*"$HOME/bin"[:$]* ]]; then
	#    PATH="$PATH:$HOME/bin"
	#fi

	export PATH_CONFIGURED="true"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

export MOZ_DBUS_REMOTE=1
export MOZ_ENABLE_WAYLAND=1
export GOPATH="$HOME/projects/go"
export GOBIN="$HOME/projects/go/bin"
export GOROOT="$HOME/.go"
