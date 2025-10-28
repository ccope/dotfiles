# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# store multiline commands as single entries
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=900000
export HISTFILESIZE=200000
export HISTFILE=~/.bash_eternal_history

PROMPT_COMMAND="history -a; history -c; history -r"
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color)
        color_prompt=yes
        ;;
    alacritty)
        color_prompt=yes
        ;;
    *color)
        color_prompt=yes
        ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# for color output default on BSD-derived coreutils
export CLICOLOR=1

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if command -v pyenv &>/dev/null; then
	eval "$(pyenv init -)"
	PYENV_INIT=1
fi

#POWERLINE="$HOME/.local/lib/python3*/site-packages/powerline/bindings/bash/powerline.sh"
#GLOBAL_PYTHON_VERSION=$(cat $PYENV_ROOT/version)
#POWERLINE="$HOME/.pyenv/versions/${GLOBAL_PYTHON_VERSION}/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh"
POWERLINE=($HOME/.local/pipx/venvs/powerline-status/lib/python3*/site-packages/powerline/bindings/bash/powerline.sh)
if [ "$color_prompt" == yes ]
then
	export LESS="-R"
	if [[ -e ${POWERLINE[-1]} ]]
	then
		powerline-daemon -q
		POWERLINE_BASH_CONTINUATION=1
		POWERLINE_BASH_SELECT=1
		. ${POWERLINE[-1]}
	else
		PS1='[\[\e[0;32m\]\u\[\e[1;37m\]@\[\e[1;37m\]\H\[\e[1;33m\]:\w$(__git_ps1 " (%s)")\[\e[0m\]]\$ '
	fi
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

SK_DIR="${HOME}/repos/github/lotabout/skim"
if [ -d "$SK_DIR/shell/" ]; then
	source "$SK_DIR/shell/key-bindings.bash"  # This loads SK completions
	source "$SK_DIR/shell/completion.bash"  # This loads SK completions
fi

unset color_prompt force_color_prompt

# Environment Variables
export COPYFILE_DISABLE=true
export EDITOR="nvim"
export DEBFULLNAME="Cameron Cope"
export DEBEMAIL="github@camcope.me"
export UBUEMAIL=$DEBEMAIL
export LC_ALL="en_US.UTF-8"
export VAGRANT_DEFAULT_PROVIDER="lxc"
if command -v rustc &>/dev/null; then
	RUST_SYSROOT=$(rustc --print sysroot)
	export RUST_SRC_PATH="${RUST_SYSROOT}/lib/rustlib/src/rust/src"
fi

if command -v rbenv &>/dev/null; then
	eval "$(rbenv init -)"
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
