# Note: this script, along with every script it calls,
#   should be written to run from bash or zsh
#   That's not too big a deal--most of the time. ;)

# It turns out getting the directory of this file is tricky if you want it to work
# on Darwin as well as most Unix variants. The following seems to do the trick.
export XDG_CONFIG_HOME="$(cd $(dirname ${BASH_SOURCE:-$_}); pwd)"

# Don't prepend these if they're already there--sometimes this file may get
# re-sourced multiple times.
[[ "$PATH" == "*$XDG_CONFIG_HOME/bin:*" ]] || export PATH="$XDG_CONFIG_HOME/bin:$PATH"
[[ "$PATH" == "*$HOME/bin:*" ]] || export PATH="$HOME/bin:$PATH"

export INPUTRC=$XDG_CONFIG_HOME/inputrc

is_executable() { type $1>/dev/null 2>&1; }
safe_alias()    { is_executable $1 || alias $1="$2"; }

# Machine-specific stuff; use dotfiles/.profile_machine-specific/$computername file for safe syncing
#   with other machines. Use ~/.profile for sensitive settings that should not be synced or published.
computername=$(uname -n | sed -e 's/\..*$//')
[[ -f $XDG_CONFIG_HOME/profile_machine-specific/$computername ]] && . $XDG_CONFIG_HOME/profile_machine-specific/$computername

# OS-specific Stuff
[[ -f $XDG_CONFIG_HOME/profile_os-specific/$(uname) ]] && . $XDG_CONFIG_HOME/profile_os-specific/$(uname)

# Program-specific stuff
for file in $(ls $XDG_CONFIG_HOME/profile_program-specific); do
  program=$(echo $file | rev | cut -d'.' -f1 | rev)
  is_executable $program && . $XDG_CONFIG_HOME/profile_program-specific/$file
done

# Miscellaneous stuff
for script in $(ls $XDG_CONFIG_HOME/profile_misc); do
  . $XDG_CONFIG_HOME/profile_misc/$script
done

[[ -d $HOME/.rvm/bin ]] && PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
