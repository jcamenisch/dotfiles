# To use a secret directory of profile overrides, set $dotsecrets before calling this script.
# If it's not set, we populate it with a nonsense value to avoid inadvertent matches when
# doing file comparisons.
[[ -n "$dotsecrets" ]] || export dotsecrets=disable-dotsecrets

# Note: this script, along with every script it calls,
#   should be written to run from bash or zsh
#   That's not too big a deal--most of the time. ;)

# It turns out getting the directory of this file is tricky if you want it to work
# on Darwin as well as most Unix variants. Thanks to "Gilles" for the following solution.
# (See https://unix.stackexchange.com/questions/96203/find-location-of-sourced-shell-script)
if [ -n "$BASH_SOURCE" ]; then
  this_script=$BASH_SOURCE
elif [ -n "$ZSH_VERSION" ]; then
  setopt function_argzero
  this_script=$0
elif eval '[[ -n ${.sh.file} ]]' 2>/dev/null; then
  eval 'this_script=${.sh.file}'
else
  echo 1>&2 "Unsupported shell. Please use bash, zsh or ksh93."
  exit 2
fi
export XDG_CONFIG_HOME="$(dirname $this_script)"

# Don't prepend these if they're already there--sometimes this file may get
# re-sourced multiple times.
[[ "$PATH" == "*$XDG_CONFIG_HOME/bin:*" ]] || export PATH="$XDG_CONFIG_HOME/bin:$PATH"
[[ "$PATH" == "*$HOME/bin:*" ]] || export PATH="$HOME/bin:$PATH"
[[ "$PATH" == "*$dotsecrets/bin:*" ]] || [[ -d "$dotsecrets/bin" ]] && export PATH="$dotsecrets/bin:$PATH"

export INPUTRC=$XDG_CONFIG_HOME/inputrc

# Shell helper functions. Load these first so they can be reused by everything else.
for script in $(ls $XDG_CONFIG_HOME/profile_helpers); do
  . $XDG_CONFIG_HOME/profile_helpers/$script
done

# general secret stuff
[[ -f "$dotsecrets/profile" ]] && . "$dotsecrets/profile"


# Machine-specific stuff
#
# Use dotfiles/.profile_machine-specific/$computername file for safe syncing to repo,
# as it will only be loaded on the machine that matches the filename.
#
# Use ~/.profile for sensitive settings that should not be published.
computername=$(uname -n | sed -e 's/\..*$//')
[[ -f $XDG_CONFIG_HOME/profile_machine-specific/$computername ]] && . $XDG_CONFIG_HOME/profile_machine-specific/$computername
[[ -f "$dotsecrets/profile_machine-specific/$computername" ]] && . "$dotsecrets/profile_machine-specific/$computername"

# OS-specific Stuff
[[ -f $XDG_CONFIG_HOME/profile_os-specific/$(uname) ]] && . $XDG_CONFIG_HOME/profile_os-specific/$(uname)
[[ -f "$dotsecrets/profile_os-specific/$(uname)" ]] && . "$dotsecrets/profile_os-specific/$(uname)"

# Program-specific stuff
#
# Load any file in the ./profile_program-specific/ directory, only if it's name matches a command
# that exists on the current system. I.e., the "bundle" script won't be sourced unless we have bundler
# installed on this machine. This allows the script to assume the presence of said command, and also
# provides a nice way to keep things organized.
for file in $(ls $XDG_CONFIG_HOME/profile_program-specific); do
  # First cut off any prefixes that end in dot (.). This is just a hack to control load order of scripts.
  # I.e., to make the 'gem' script load before the 'bundle' script, we can rename 'gem' to '0.gem'--
  # or any prefix that makes it sort alphabetically before 'bundle'
  program=$(echo $file | awk -F'.' '{ print $NF }')
  is_executable $program && . $XDG_CONFIG_HOME/profile_program-specific/$file
done

# Miscellaneous stuff
for script in $(ls $XDG_CONFIG_HOME/profile_misc); do
  . $XDG_CONFIG_HOME/profile_misc/$script
done
