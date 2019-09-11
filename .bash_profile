#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

###########################################################################

# Add Git AutoCompletion
if [ -f  ~/.git-completion.bash ]; then
        source ~/.git-completion.bash
fi

# Configure proxy
if [ -f  ~/.bash_proxy.sh ]; then
        source ~/.bash_proxy.sh
fi

export EDITOR=vim
export SVN_EDITOR=vim

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
. /etc/bash_completion
fi

###########################################################################
# Aliases

alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"'
alias alert='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "[0] "'

alias netstat-listen='netstat -lepunt'
alias whereami='curl ipinfo.io'
