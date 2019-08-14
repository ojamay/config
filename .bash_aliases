#alias hgrep='history | grep'
alias phpfix='php-cs-fixer fix . --show-progress estimating --verbose --rules=@PSR2,@PSR1,@Symfony,-phpdoc_annotation_without_dot,-phpdoc_summary,-trailing_comma_in_multiline_array,-pre_increment,-yoda_style'

services_restart() {
    sudo service nginx restart;
    sudo service kraken-iv restart;
    sudo service uwsgi restart;
}
alias services_restart=services_restart

#alias folder='cd ~/folder/'
