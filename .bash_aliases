alias hgrep='history | grep'
alias phpfix='php-cs-fixer fix . --show-progress estimating --verbose --rules=@PSR2,@PSR1,@Symfony,-phpdoc_annotation_without_dot,-phpdoc_summary,-trailing_comma_in_multiline_array,-pre_increment,-yoda_style'
alias targz='tar -cvfz'
alias untargz='tar -xvfz'
#alias tree='tree -C'

#frep() { sudo find $1 -path "*/cache" -prune -o -path "*/logs" -prune -o -path "*/.svn" -prune -o -path "*~" -prune -o -print0 |sudo xargs -0 grep -si --color=always "$2"; }
#alias fgrep_content='sudo find . -path "*/cache" -prune -o -path "*/logs" -prune -o -path "*/.svn" -prune -o -path "*~" -prune -o -print0 |sudo xargs -0 grep -si --color=always '
#alias fgrep=fgrep

#tree() { find . | sort | sed -e "s/[^-][^\/]*\//  │/g" -e "s/│\([^ ]\)/├──\1/"; }
#tred() { find . -type d | sort | sed -e "s/[^-][^\/]*\//  │/g" -e "s/│\([^ ]\)/├──\1/"; }
#alias tree=tree
#alias tred=tred

# Project

alias services_restart="
    sudo service nginx restart;
    sudo service kraken-iv restart;
    sudo service uwsgi restart;"

#alias folder='cd ~/folder/'
