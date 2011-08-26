# Note: this script, along with every script it calls,
#   should be written to run from bash or zsh
#   That's not too big a deal--most of the time. ;)
computername=`uname -n | sed -e 's/\..*$//'`
export PATH="/usr/local/bin:/usr/local/sbin:$PATH:~/bin"

# Aliases and shortcuts
alias ls="ls -G"
alias lsl="ls -l"
alias lsa="ls -a"
alias lsla="ls -la"
mdcd () { mkdir $1 ; cd $1 ; }
sshmt () { ssh serveradmin@$1@$1 ; }

# Program-specific stuff
if which git>/dev/null; then
  ga () { git add $* && git status ; }
  alias gb="git bisect"
  alias gl="git log"
  alias gs="git status"
  alias gps="git push"
  alias gpshm="git push heroku master"
  alias gc="git checkout"
  alias gcm="git commit -m"
  alias gca="git commit --amend"
  alias sinatra="ruby -rubygems"
  gpl() {
    if [[ $(git pull) == 'Already up-to-date.' ]]; then
      echo 'Already up-to-date.'
    else
      bundle install && [[ -f ./tmp/restart.txt ]] && touch ./tmp/restart.txt
    fi
  }
fi
if which bundle>/dev/null; then
  alias b="bundle"
  alias be="bundle exec"
  alias bi="bundle install"
  alias bu="bundle update"
  alias cuc="bundle exec cucumber"
  alias rk="bundle exec rake"
  alias rkdm="bundle exec rake db:migrate"
  alias r="bundle exec script/rails"
  alias rc="bundle exec script/rails console"
  alias rs="bundle exec script/rails server"
  alias bess="bundle exec script/server"
  alias ru="bundle exec rackup"
fi
if which ruby>/dev/null; then
  LANG=en_US.UTF-8
  
  cd_masked () {
    # For lazy typists, use this in an alias to get to working directories you often use.
    # For example,
    #   alias c="cd_masked %1"
    # would allow the command
    #   c ~/p/ac/www
    # to take you to
    #   ~*/p*/ac*/www (which bash translates to, say, ~/projects/acme/www)
    #
    # For a very oft-used pattern, you could set up something more specialized like
    #   alias cdp="cd_masked ~/projects/%1/www/%2"
    # which would allow the command
    #   cdp ac
    # to get to
    #   ~/projects/ac*/www (e.g., ~/projects/acme/www)
    # or even
    #   cdp ac p/s/s
    # to get to
    #   ~/projects/ac*/www/p*/s*/s* (as in, ~/projects/acme/www/public/stylesheets/sass)

    cd $(ruby -e "
      puts ARGV[0].gsub( /%([0-9])/ ) {|match|
        (ARGV[\$1.to_i] ? ARGV[\$1.to_i]+'*' : '' ).gsub(/(.)\//,'\\\\1*/')
      }
    " $@)
  }

  alias c="cd_masked %1"

  MT_ACCT=`echo $HOME | ruby -e 'puts $~[1] if $_ =~ %r"/home/([0-9]+)/users/.home"' 2>/dev/null`
  [ "$MT_ACCT" != "" ] && . ~/.profile_mediatemple
fi

# OS-specific Stuff
[[ -f ~/.profile_`uname` ]] && . ~/.profile_`uname`

# Machine-specific stuff; use dotfiles/.profile_$computername file for safe syncing
#   with other machines. Use ~/.profile_local for sensitive settings that should not
#   be synced or published.
[[ -f ~/.profile_$computername ]] && . ~/.profile_$computername
[[ -f ~/.profile_local ]] && . ~/.profile_local

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
