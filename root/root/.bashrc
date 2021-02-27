# Make bash check its window size after a process completes
shopt -s checkwinsize

HISTCONTROL=ignoreboth:ignoredups:erasedups
HISTSIZE=10000
HISTIGNORE="ls:ll"
UNAME=$(uname)
shopt -s histappend
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD##*/}\007"'

if [ -d ~/.bashrc.d ]; then
    for i in $(ls ~/.bashrc.d/* 2> /dev/null) ; do
        . $i
    done
fi

if [ -d ~/.bash_completion.d ]; then
    for i in $(ls ~/.bash_completion.d/* 2> /dev/null) ; do
        . $i
    done
fi

# if [ "$PS1" ]; then
    # PS1="\[\033[1;31m\][\w] \[\033[1;34m\]-\u@\h-\[\033[1;33m\] \\$\[\033[0m\] "

    # for i in /etc/profile.d/*
    # do
        # . $i
    # done
# fi

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias ls='ls -FA --color=auto'
alias ll='ls -l --color=auto'
alias l.='ls -d .[a-zA-Z]* --color=auto'

function s {
    if [ -n "$1" ]; then
        if [ -n "$(which ag)" ]; then
            ag "$1"
        else
            grep "$1" * -r -i -a
        fi
    fi
}

function f { find . -depth -path "*" -iname "$1" -type f -print; }
function fd { find . -depth -path "*" -iname "$1" -type d -print; }

if [ -f "$BASH_COMPLETION_PREFIX/etc/bash_completion" ]; then
    . "$BASH_COMPLETION_PREFIX/etc/bash_completion"
fi
