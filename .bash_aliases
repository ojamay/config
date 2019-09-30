# Basic
alias hgrep='history | grep'
alias targz='tar -cvfz'
alias untargz='tar -xvfz'
#alias tree='tree -C' # YMJ to adapt

# Alert
alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"'
#alias alert='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "[0] "'

# Dev
alias phpfix='php-cs-fixer fix . --show-progress estimating --verbose --rules=@PSR2,@PSR1,@Symfony,-phpdoc_annotation_without_dot,-phpdoc_summary,-trailing_comma_in_multiline_array,-pre_increment,-yoda_style'

# Network
alias network_whereami='curl ipinfo.io; echo'
alias network_monip="curl -s monip.org | iconv -f iso-8859-1 | sed -n 's/.*IP : \([0-9.]*\).*/\1/p'"
alias network_scan='nmap -T4 -sP 192.168.0.0/24' # 192.168.0.0/24
alias network_ipinfo='nmap -A -T4' # IP
alias network_netstat-listen='netstat -lepunt'
alias network_connections='netstat | grep EST'

# SSH
alias ssh_invalid='grep sshd.\*Invalid /var/log/auth.log'
alias ssh_failed='grep sshd.\*Failed /var/log/auth.log'
alias ssh_scanned='grep sshd.*Did /var/log/auth.log'
alias ssh_success='grep sshd.*opened /var/log/auth.log'

# Functions
f_fxgrep() { find $1 -path "*/cache" -prune -o -path "*/logs" -prune -o -path "*/.svn" -prune -o -path "*~" -prune -o -print0 | xargs -0 grep -si --color=always "$2"; }
alias fxgrep=f_fxgrep

f_tree() { find . | sort | sed -e "s/[^-][^\/]*\//  │/g" -e "s/│\([^ ]\)/├──\1/"; }
alias tree=f_tree
f_tred() { find . -type d | sort | sed -e "s/[^-][^\/]*\//  │/g" -e "s/│\([^ ]\)/├──\1/"; }
alias tred=f_tred

# Project
#alias services_restart="
#    sudo service nginx restart;
#    sudo service kraken-iv restart;
#    sudo service uwsgi restart;"

#alias folder='cd ~/folder/'
