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

  if [ `type -P ruby` ]; then
    cd `ruby -e "
      puts ARGV[0].gsub( /%([0-9])/ ) {|match|
        (ARGV[\\$1.to_i] ? ARGV[\\$1.to_i]+'*' : '' ).gsub(/(.)\//,'\\\\1*/')
      }
    " $@`
    pwd
  else
    echo "Sorry, this machine doesn't have ruby installed"
  fi
}
sshmt () { ssh serveradmin@$1@$1 ; }

computername=`uname -n | sed -e 's/\..*$//'`
export PATH="~/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export PS1="\[\e]2;$computername/\w |\a\]\[\e[30;42m\]:\[\e[0m\] "

alias ls="ls -G"
alias lsl="ls -l"
alias lsla="ls -la"
alias c="cd_masked %1"
if [ `type -P git` ]; then
  alias ga="git add"
  alias gs="git status"
  alias gps="git push"
  alias gpshm="git push heroku master"
  alias gpl="git pull"
  alias gcm="git commit -m"
  alias sinatra="ruby -rubygems"
fi
if [ `type -P bundle` ]; then
  alias bess="bundle exec script/server"
fi

# OS-specific Stuff
if [ -f ~/.bashrc_`uname` ]; then . ~/.bashrc_`uname`; fi

# System-specific stuff; use dotfiles/.bashrc_$computername file for benign syncing
#   with other machines. Use ~/.bashrc_local for sensitive settings that should not
#   be synced or published.
if [ -f ~/.bashrc_$computername ]; then . ~/.bashrc_$computername ; fi
if [ -f ~/.bashrc_local ]; then . ~/.bashrc_local ; fi

if [ `type -P ruby` ]; then
  MT_ACCT=`echo $HOME | ruby -e 'puts $~[1] if gets =~ %r"/home/([0-9]+)/users/.home"'`
  if [ $MT_ACCT ]; then . ~/.bashrc_mediatemple ; fi
fi
