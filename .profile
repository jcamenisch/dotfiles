computername=`uname -n | sed -e 's/\..*$//'`
export PATH="/usr/local/bin:/usr/local/sbin:$PATH:~/bin"

# Aliases and shortcuts
alias ls="ls -G"
alias lsl="ls -l"
alias lsa="ls -a"
alias lsla="ls -la"
alias c="cd_masked %1"
mdcd () { mkdir $1 ; cd $1 ; }
sshmt () { ssh serveradmin@$1@$1 ; }

# Program-specific stuff
if [ `which git` ]; then
  alias ga="git add"
  alias gl="git log"
  alias gs="git status"
  alias gps="git push"
  alias gpshm="git push heroku master"
  alias gpl="git pull"
  alias gc="git commit"
  alias gcm="git commit -m"
  alias gca="git commit --amend"
  alias sinatra="ruby -rubygems"
fi
if [ `which bundle` ]; then
  alias b="bundle"
  alias be="bundle exec"
  alias bec="bundle exec cucumber"
  alias ber="bundle exec rake"
  alias besr="bundle exec script/rails"
  alias besrc="bundle exec script/rails console"
  alias besrs="bundle exec script/rails server"
  alias bess="bundle exec script/server"
  alias beru="bundle exec rackup"
  alias bi="bundle install"
fi
if [ `which ruby` ]; then
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

    cd `ruby -e "
      puts ARGV[0].gsub( /%([0-9])/ ) {|match|
        (ARGV[\\$1.to_i] ? ARGV[\\$1.to_i]+'*' : '' ).gsub(/(.)\//,'\\\\1*/')
      }
    " $@`
  }

  MT_ACCT=`echo $HOME | ruby -e 'puts $~[1] if $_ =~ %r"/home/([0-9]+)/users/.home"'`
  [[ "$MT_ACCT" -ne "" ]] && . ~/.bashrc_mediatemple
fi

# OS-specific Stuff
[[ -f ~/.bashrc_`uname` ]] && . ~/.bashrc_`uname`

# Machine-specific stuff; use dotfiles/.bashrc_$computername file for safe syncing
#   with other machines. Use ~/.bashrc_local for sensitive settings that should not
#   be synced or published.
[[ -f ~/.bashrc_$computername ]] && . ~/.bashrc_$computername
[[ -f ~/.bashrc_local ]] && . ~/.bashrc_local

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
