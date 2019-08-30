alias hgrep='history | grep'
alias phpfix='php-cs-fixer fix . --show-progress estimating --verbose --rules=@PSR2,@PSR1,@Symfony,-phpdoc_annotation_without_dot,-phpdoc_summary,-trailing_comma_in_multiline_array,-pre_increment,-yoda_style'

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
