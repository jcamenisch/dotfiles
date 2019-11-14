#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

[[ -z "$ZDOTDIR" ]] && export ZDOTDIR="${0%/*}"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Customize to your needs...
setopt glob_subst
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-pattern-search-backward
# Remap Ctrl-S to Ctrl-- for stopping termianl output
stty start  stop 

[[ -f ${0%/*}/bin/tmuxinator.zsh ]] && source ${0%/*}/bin/tmuxinator.zsh

is_executable rspec && alias rspec='nocorrect rspec'

# autoload -Uz compinit promptinit
# compinit
# promptinit
# prompt bart

# History and history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# Git info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
precmd() {
  vcs_info
}

# precmd() {
#   LEFT='%F{magenta}%n%f at %F{yellow}%m%f in %F{green}%~%f ${vcs_info_msg_0_}'
#   RIGHT="%{$reset_color%}$(date '+%H:%M:%S') "
#   RIGHTWIDTH=$(($COLUMNS-${#LEFT}))
#   print $LEFT${(l:$RIGHTWIDTH::.:)RIGHT}
# }
PS1='%F{magenta}%n%f at %F{yellow}%m%f in %F{green}%~%f ${vcs_info_msg_0_} • %D{%H:%M:%S}
$ '
#RPROMPT='%D{%H:%M:%S}'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
