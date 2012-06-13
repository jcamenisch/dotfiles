# Note: this script, along with every script it calls,
#   should be written to run from bash or zsh
#   That's not too big a deal--most of the time. ;)
computername=`uname -n | sed -e 's/\..*$//'`
email=`echo 'onjthan@aamcniechsne.t' | sed -e "s/\(.\)\(.\)\(.\)/\3\1\2/g"`

# Aliases and shortcuts
alias ls="ls -G"
alias lsl="ls -l"
alias lsa="ls -a"
alias lsla="ls -la"
alias profile=". ~/.profile"
alias vip="vi ~/.profile"
mdcd () { mkdir $1 ; cd $1 ; }
sshmt () { ssh serveradmin@$1@$1 ; }

# Program-specific stuff
for program in $(ls program_specific_configs); do
  which $program>/dev/null && . program_specific_configs/$program
done

# OS-specific Stuff
[[ -f ~/.profile_`uname` ]] && . ~/.profile_`uname`

# Machine-specific stuff; use dotfiles/.profile_$computername file for safe syncing
#   with other machines. Use ~/.profile_local for sensitive settings that should not
#   be synced or published.
[[ -f ~/.profile_$computername ]] && . ~/.profile_$computername
[[ -f ~/.profile_local ]] && . ~/.profile_local

export PATH="$PATH:$HOME/bin"
