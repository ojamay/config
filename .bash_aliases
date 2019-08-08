# default

alias ls='ls --color=auto'
alias bashrl="source ~/.bashrc"

# ymj default reset

alias l='ls -CF'
alias ll='ls -lhF'
alias la='ls -AlhF'

# ymj

find_grep()       { find $1 -path "*/cache" -prune -o -path "*/logs" -prune -o -path "*/.svn" -prune -o -path "*~" -prune -o -print0 | xargs -0 grep -s --color=always "$2"; }
alias fgrep_content='find . -path "*/cache" -prune -o -path "*/logs" -prune -o -path "*/.svn" -prune -o -path "*~" -prune -o -print0 | xargs -0 grep -s --color=always'

alias fgrep=find_grep
alias hgrep="history | grep"

alias phpfix="php-cs-fixer fix . --show-progress estimating --verbose --rules=@PSR2,@PSR1,@Symfony,-phpdoc_annotation_without_dot,-phpdoc_summary,-trailing_comma_in_multiline_array,-pre_increment,-yoda_style"

alias gitlog="git log --graph --decorate --pretty=oneline --abbrev-commit"
alias gitlogall="git log --graph --pretty=format:'%C(yellow)%h%Creset%C(blue)%d%Creset %C(normal)%s%Creset %C(cyan dim)(by %an %ar)%Creset' --all"
alias gitlogbranch="git log --graph --simplify-by-decoration --pretty=format:'%d' --all"

