# debian default
alias ls='ls --color=auto'
alias l='ls -CF'
alias ll='ls -lhF'
alias lla='ls -AlhF'
alias bashrl="source ~/.bashrc"

# my
alias hgrep="history | grep"
alias phpfix="php-cs-fixer fix . --show-progress estimating --verbose --rules=@PSR2,@PSR1,@Symfony,-phpdoc_annotation_without_dot,-phpdoc_summary,-trailing_comma_in_multiline_array,-pre_increment,-yoda_style"
alias gitlog="git log --graph --decorate --pretty=oneline --abbrev-commit"
alias gitlogall="git log --graph --pretty=format:'%C(yellow)%h%Creset%C(blue)%d%Creset %C(normal)%s%Creset %C(cyan dim)(by %an %ar)%Creset' --all"
alias gitlogbranch="git log --graph --simplify-by-decoration --pretty=format:'%d' --all"
