alias gitlog='git log --pretty="%C(yellow)%h%Creset%C(auto)%d%Creset %C(normal)%s%Creset %C(cyan dim)(par %an %ar)%Creset"'
alias hgrep='history | grep'
alias phpfix='php-cs-fixer fix . --show-progress estimating --verbose --rules=@PSR2,@PSR1,@Symfony,-phpdoc_annotation_without_dot,-phpdoc_summary,-trailing_comma_in_multiline_array,-pre_increment,-yoda_style'

findd() { find $1 -type d; }
alias findd=findd

services_restart() {
    sudo service nginx restart;
    sudo service kraken-iv restart;
    sudo service uwsgi restart;
}
alias services_restart=services_restart
