#fgrep() { find $1 -path "*/cache" -prune -o -path "*/logs" -prune -o -path "*/.svn" -prune -o -path "*~" -prune -o -print0 | xargs -0 grep -s --color=always "$2"; }
#alias fgrep=fgrep

alias gitlog='git log --graph --decorate --pretty=oneline --abbrev-commit'
alias gitlogall="git log --graph --pretty=format:'%C(yellow)%h%Creset%C(blue)%d%Creset %C(normal)%s%Creset %C(cyan dim)(by %an %ar)%Creset' --all"
alias gitlogbranch="git log --graph --simplify-by-decoration --pretty=format:'%d' --all"

alias hgrep='history | grep'

list_tree() { find $1 -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"; }
alias lt=list_tree

alias phpfix='php-cs-fixer fix . --show-progress estimating --verbose --rules=@PSR2,@PSR1,@Symfony,-phpdoc_annotation_without_dot,-phpdoc_summary,-trailing_comma_in_multiline_array,-pre_increment,-yoda_style'

services_restart() {
    sudo service nginx restart;
    sudo service kraken-iv restart;
    sudo service uwsgi restart;
}
alias services_restart=services_restart
