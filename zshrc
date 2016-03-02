#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

[[ -z "$ZDOTDIR" ]] && export ZDOTDIR="$(dirname $_)"

# Source Prezto.
[[ -s "$ZDOTDIR/.zprezto/init.zsh" ]] && source "$ZDOTDIR/.zprezto/init.zsh"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Customize to your needs...
source $ZDOTDIR/profile
setopt glob_subst
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-pattern-search-backward
# Remap Ctrl-S to Ctrl-- for stopping termianl output
stty start  stop 

[[ -f $(dirname $_)/bin/tmuxinator.zsh ]] && source $(dirname $_)/bin/tmuxinator.zsh

is_executable rspec && alias rspec='nocorrect rspec'

# Mostly just using the steeef prompt theme, but add this one slight enhancement:
RPROMPT='%{$reset_color%}%D{%H:%M:%S}'
