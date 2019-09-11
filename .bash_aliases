# project
alias services_restart="
    sudo service nginx restart;
    sudo service kraken-iv restart;
    sudo service uwsgi restart;"

#alias folder='cd ~/folder/'

# ojm
alias hgrep='history | grep'
alias targz='tar -cvfz'
alias untargz='tar -xvfz'
alias phpfix='php-cs-fixer fix . --show-progress estimating --verbose --rules=@PSR2,@PSR1,@Symfony,-phpdoc_annotation_without_dot,-phpdoc_summary,-trailing_comma_in_multiline_array,-pre_increment,-yoda_style'

#alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"'
#alias alert='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "[0] "'

# Show the TCP and UDP ports being listened on and if you're root, also show the process associated, user, etc.
#alias netstat_listen='netstat -lepunt'

#alias whereami='curl ipinfo.io'

#fgrep() { sudo find $1 -path "*/cache" -prune -o -path "*/logs" -prune -o -path "*/.svn" -prune -o -path "*~" -prune -o -print0 |sudo xargs -0 grep -si --color=always "$2"; }
#alias fgrep_content='sudo find . -path "*/cache" -prune -o -path "*/logs" -prune -o -path "*/.svn" -prune -o -path "*~" -prune -o -print0 |sudo xargs -0 grep -si --color=always '
#alias fgrep=fgrep

#tree() { find . | sort | sed -e "s/[^-][^\/]*\//  │/g" -e "s/│\([^ ]\)/├──\1/"; }
#tred() { find . -type d | sort | sed -e "s/[^-][^\/]*\//  │/g" -e "s/│\([^ ]\)/├──\1/"; }
#alias tree=tree
#alias tred=tred
