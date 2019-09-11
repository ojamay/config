# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm*|rxvt*) color_prompt=yes;;
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

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ "$color_prompt" = yes ]; then
    if [ "$(id -u)" != 0 ]; then
        PS1="\[\033[0;38;5;33m\]\t \u\[\033[0m\]@\[\033[0;38;5;33m\]\h\[\033[0m\] \W\[\033[33m\]\$(parse_git_branch) \[\033[0;38;5;33m\]>\[\033[0m\] "
    else
        PS1="\[\033[0;38;5;166m\]\t \u\[\033[0m\]@\[\033[0;38;5;166m\]\h\[\033[0m\] \W \[\033[0;38;5;166m\]>\[\033[0m\] "
    fi  
else
    if [ "$(id -u)" != 0 ]; then
        PS1="\[\033[0;38;5;34m\]\t \u\[\033[0m\]@\[\033[0;38;5;34m\]\h\[\033[0m\] \W\[\033[33m\]\$(parse_git_branch) \[\033[0;38;5;34m\]>\[\033[0m\] "
    else
        PS1="\[\033[0;31m\]\t \u\[\033[0m\]@\[\033[0;31m\]\h\[\033[0m\] \W \[\033[0;31m\]>\[\033[0m\] "
    fi  
fi  
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

#setxkbmap -option "nbsp:none"

if [ "$(id -u)" = 0 ]; then
    PATH=$PATH:/root/bin
    alias dpkgpurge="dpkg --purge $(COLUMNS=200 dpkg -l | grep "^rc" | tr -s ' ' | cut -d ' ' -f 2)"
fi  

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -lhF'
alias lla='ls -AlhF'
alias l='ls -CF'
alias la='ls -AhF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias bashrl="source $HOME/.bashrc"

export EDITOR="vim"
export SVN_EDITOR="$EDITOR"
export GIT_EDITOR="$EDITOR"
export TERM="rxvt-unicode"
unset SSH_ASKPASS

function randompass {
    < /dev/urandom tr -dc A-Za-z0-9 | head -c ${1:-16}; echo;
}

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
    function command_not_found_handle {
            # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
           /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
           /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
        else
           printf "%s: command not found\n" "$1" >&2
           return 127
        fi
    }
fi

# Add Git AutoCompletion
if [ -f  ~/.git-completion.bash ]; then
        source ~/.git-completion.bash
fi
