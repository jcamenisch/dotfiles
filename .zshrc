#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
[[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]] && source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Customize to your needs...
# export PATH=/Users/jcamenisch/.rvm/gems/ruby-1.9.2-p180/bin:/Users/jcamenisch/.rvm/gems/ruby-1.9.2-p180@global/bin:/Users/jcamenisch/.rvm/rubies/ruby-1.9.2-p180/bin:/Users/jcamenisch/.rvm/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:~/bin
. ~/.profile
setopt glob_subst
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-pattern-search-backward
# Remap Ctrl-S to Ctrl-- for stopping termianl output
stty start  stop 

[[ -f ~/bin/tmuxinator.zsh ]] && source ~/bin/tmuxinator.zsh

is_executable rspec && alias rspec='nocorrect rspec'
