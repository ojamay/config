#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

###########################################################################
# Configure prompt
# see https://github.com/nicolargo/dotfiles/blob/master/_bashrc.d/bashrc_prompt_1line
###########################################################################

# Colors
NoColor="\033[0m"
Cyan="\033[0;36m"
Green="\033[0;32m"
Red="\033[0;31m"
Yellow="\033[0;33m"

# Chars
RootPrompt="\n\#"
NonRootPrompt="\n\$"

# Contextual prompt
prompt() {

        USERNAME=`whoami`
        HOSTNAME=`hostname -s`
        #CURRENTPATH=`pwd | sed "s|$HOME|~|g"`

        # Change the Window title
        WINDOWTITLE="$USERNAME@$HOSTNAME"
        echo -ne "\033]0;$WINDOWTITLE\007"

        # Change the dynamic prompt
        #LEFTPROMPT="$Yellow$CURRENTPATH"
        LEFTPROMPT="\[$Cyan\]$USERNAME@$HOSTNAME":"\[$Yellow\]\w"

        GITSTATUS=$(git status 2> /dev/null)
        if [ $? -eq 0 ]; then
                echo $GITSTATUS | grep "not staged" > /dev/null 2>&1
                if [ $? -eq 0 ]; then
                        LEFTPROMPT=$LEFTPROMPT"\[$Red\]"
                else
                        LEFTPROMPT=$LEFTPROMPT"\[$Green\]"
                fi
                # BRANCH=`git describe --contains --all HEAD`
                BRANCH=`git rev-parse --abbrev-ref HEAD`
                LEFTPROMPT=$LEFTPROMPT" ["$BRANCH"]"
        fi

        if [ $EUID -ne 0 ]; then
                PS1=$LEFTPROMPT"\[$NoColor\] "$NonRootPrompt" "
        else
                PS1=$LEFTPROMPT"\[$NoColor\] "$RootPrompt" "
        fi

        # echo -e -n $LEFTPROMPT
}

# Define PROMPT_COMMAND if not already defined (fix: Modifying title on SSH connections)
if [ -z "$PROMPT_COMMAND" ]; then
        case $TERM in
        xterm*)
                PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
        ;;
        screen)
                PROMPT_COMMAND='printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
        ;;
        esac
fi

# Main prompt
PROMPT_COMMAND="prompt;$PROMPT_COMMAND"

if [ $EUID -ne 0 ]; then
        PS1=$NonRootPrompt" "
else
        PS1=$RootPrompt" "
fi

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

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
#alias tree='tree -C'
#alias targz='tar -cvfz'
#alias untargz='tar -xvfz'
alias fxgrep_content='sudo find . -path "*/cache" -prune -o -path "*/logs" -prune -o -path "*/.svn" -prune -o -path "*~" -prune -o -print0 |sudo xargs -0 grep -si --color=always '

alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"'
alias alert='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "[0] "'

alias netstat-listen='netstat -lepunt'
alias whereami='curl ipinfo.io'

# Sudo
#alias php='sudo php'
#alias vim='sudo vim'
#alias svn='sudo svn'

# Logs
alias alog='tail -n 50 /var/log/apache2/access.log'
alias elog='tail -n 50 /var/log/apache2/error.log'

# Project PROJECT
#alias oss_p='cd ~/PROJECT/'
#alias oss_symfony='cd ~/PROJECT/var/www/domain.tld/'
#alias oss_sonata='cd ~/PROJECT/var/www/domain.tld/src/Customer/AppBundle/'

# PostgreSQL
#export PG_HOME="/usr/local/pgsql"
#export PGDATA="/usr/local/pgsql/data/"
# export PG_HOME="/Library/PostgreSQL8"

# MySQL
#alias mysql=/usr/local/mysql/bin/mysql
#alias mysqladmin=/usr/local/mysql/bin/mysqladmin

# Functions
find_grep() { sudo find $1 -path "*/cache" -prune -o -path "*/logs" -prune -o -path "*/.svn" -prune -o -path "*~" -prune -o -print0 |sudo xargs -0 grep -si --color=always "$2"; }
alias fxgrep=find_grep

list_tree() { find $1 -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/" }
alias lt=list_tree

list_files() { find $1 | sed 's|[^/]*/|- |g' }
alias lf=list_files

proj_cc() {
    CURRENT=`pwd`;
    cd ~/PROJECT/var/www/domain.tld/;
    sudo ~/PROJECT/var/www/domain.tld/cc.bash;
    sudo chown -R ${USER}:root ~/PROJECT;
    cd ${CURRENT};
}
alias proj_cc=proj_cc
