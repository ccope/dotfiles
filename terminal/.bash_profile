# .bash_profile
output(){
    if [ -f ~/.profiledebug ] && [ -n "$1" ]; then
        echo "$1";
    fi;
}

# Get the aliases and functions
[[ -s ${HOME}/.profile ]] && . ${HOME}/.profile

# Adjust .bash_history size
export HISTSIZE=50000
export HISTFILESIZE=20000
HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s cmdhist
PROMPT_COMMAND='history -a'
EDITOR=vim

GIT_PS1_SHOWDIRTYSTATE=0
GIT_PS1_SHOWSTASHSTATE=0
GIT_PS1_SHOWUNTRACKEDFILES=0
GIT_PS1_SHOWUPSTREAM="auto"


# Mac or Linux?
UNAME=`uname -s`;
output "Using BASH profile for ${UNAME}";

alias ..='cd ..'  
alias ...='cd ../..'  
alias +='pushd .' 

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Command Aliases
if [ $UNAME == 'Darwin' ]; then
    output "Configuring ${UNAME} aliases...";
    alias ll='ls -AohGF';
    alias sshx='ssh -Y';
    alias top='top -o cpu';
    alias tree='tree -DCF';
    alias cdg='cd /Users/`whoami`/chef/chef-repo';
elif [ $UNAME == 'Linux' ]; then
    output "Configuring ${UNAME} aliases...";
    alias ll='ls -alhGF --color';
    if [ -f /etc/debian_version ]; then
        alias cdng='cd /etc/nagios3';
    else
        alias cdng='cd /usr/local/nagios';
    fi
    alias cdbc='cd /usr/local/brightcove';
    alias atup='atop -A -v -f 3'; 
    alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
    alias nags='cd ~/cfengine/repository/classes/tools/usr/local/nagios/etc/;svn update;vim services.cfg'
    alias genup='cd ~/cfengine/repository/classes/base/etc;svn up;mv -f ~/genders-$(dnsdomainname) genders;svn diff; nodeattr --parse-check -f genders'
fi;

#alias grep='grep --color=auto';
export GREP_OPTIONS='--color=auto'

# PS1 Setup:
if [ $UNAME == 'Linux' ]; then
    case `hostname -d` in
        "DOMAIN")            HOSTCOLOR=31;; # Red
        "DOMAIN2")           HOSTCOLOR=36;; # Cyan
        "DOMAIN3")           HOSTCOLOR=37;; # White
        "DOMAIN4")           HOSTCOLOR=34;; # Blue
        "DOMAIN5")           HOSTCOLOR=30;; # Black
        "DOMAIN6")           HOSTCOLOR=35;; # Magenta
    esac;
fi;

if [ -z "$HOSTCOLOR" ]; then
    output "No domain preference found. Setting to default...";
    HOSTCOLOR=37; # White
fi;

export PS1='[\[\e[0;32m\]\u\[\e[1;37m\]@\[\e[1;${HOSTCOLOR}m\]\H\[\e[1;33m\]:\w$(__git_ps1 " (%s)")\[\e[0m\]]\$ '

# Environment Variables
export COPYFILE_DISABLE=true

# Perforce Setup
if [ -f /usr/local/bin/p4 ]; then
    output "Configuring Perforce Settings...";
    export P4USER='ccope'
    export P4PORT='hostname:port'
    export P4CONFIG='p4config.txt'
    export P4CLIENT='ccope-box'
    export P4EDITOR='vim +/"<enter description here>" -c "%s/<enter description here>/null\r    Reviewer:syseng/g" -c "%s/null/ /g"'
    output "P4CLIENT=$P4CLIENT, P4PORT=$P4PORT";
fi

export CLICOLOR=1

# User specific environment and startup programs

export PATH=/sbin:/usr/sbin:$PATH
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
LC_ALL="en_US.UTF-8"
