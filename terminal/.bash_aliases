# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Command Aliases
if command -v lsd &>/dev/null; then
    alias l='ls -l'
    alias ls='lsd'
    alias la='ls -a'
    alias lla='ls -la'
    alias lt='ls --tree'
else
# gnu ls
    alias ll='ls -alhGF --color=auto'
fi
if command -v bat &>/dev/null; then
    alias cat='bat'
fi
alias atup='atop -A -v -f 3';
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias ..='cd ..'
alias ...='cd ../..'
alias +='pushd .'
if command -v nvim &>/dev/null; then
    alias vim='nvim'
    alias vi='nvim'
    alias vimdiff='nvim -d'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

skvi() {
	x="$(sk --bind "ctrl-p:toggle-preview" --ansi --preview="preview.sh -v {}" --preview-window=up:50%:hidden)"
	[[ $? -eq 0 ]] && vim "$x" || true
}

rgvi() {
	x="$(sk --bind 'ctrl-p:toggle-preview' --ansi -i -c 'rg --color=always --line-number \"{}\"' --preview='preview.sh -v {}' --preview-window=up:50%:hidden)"
	[[ $? -eq 0 ]] && vim "$(echo $x|cut -d: -f1)" "+$(echo $x|cut -d: -f2)" || true
}

alias luamake=/home/cam/projects/factorio/lua-language-server/3rd/luamake/luamake
