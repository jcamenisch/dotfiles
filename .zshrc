# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="jonathancamenisch"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(ls git brew gem osx rvm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# export PATH=/Users/jcamenisch/.rvm/gems/ruby-1.9.2-p180/bin:/Users/jcamenisch/.rvm/gems/ruby-1.9.2-p180@global/bin:/Users/jcamenisch/.rvm/rubies/ruby-1.9.2-p180/bin:/Users/jcamenisch/.rvm/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:~/bin
setopt glob_subst
. ~/.profile
# Uncomment to re-enable RVM
# [[ -s "/Users/jcamenisch/.rvm/scripts/rvm" ]] && source "/Users/jcamenisch/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
