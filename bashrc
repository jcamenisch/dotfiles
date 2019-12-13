shopt -s extglob
export HISTFILE=$(dirname ${BASH_SOURCE[0]})/.bash_history_$USER
. $(dirname ${BASH_SOURCE[0]})/profile
computer_color=$(color_from_string $computername)
PS1='\[\e[38;5;${computer_color}m\]$([ -n "$SSH_CONNECTION" ] && echo '\\h:')\w · \t\[\e[0m\]\n$ '
