shopt -s extglob
export PS1="\[\e]2;$computername:\w |\a\]\[\e[30;42m\]:\[\e[0m\] "
. $(dirname ${BASH_SOURCE[0]})/profile
