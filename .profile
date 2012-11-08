# Note: this script, along with every script it calls,
#   should be written to run from bash or zsh
#   That's not too big a deal--most of the time. ;)

# Shortcuts (aliases and functions)
for script in $(ls ~/.profile_shortcuts); do
  . ~/.profile_shortcuts/$script
done

# Program-specific stuff
for program in $(ls ~/.profile_program-specific); do
  which $program>/dev/null && . ~/.profile_program-specific/$program
done

# OS-specific Stuff
[[ -f ~/.profile_os-specific/$(uname) ]] && . ~/.profile_os-specific/$(uname)

# Machine-specific stuff; use dotfiles/.profile_machine-specific/$computername file for safe syncing
#   with other machines. Use ~/.profile_local for sensitive settings that should not
#   be synced or published.
computername=$(uname -n | sed -e 's/\..*$//')
[[ -f ~/.profile_machine-specific/$computername ]] && . ~/.profile_machine-specific/$computername
[[ -f ~/.profile_local ]] && . ~/.profile_local

export PATH="$PATH:$HOME/bin"
