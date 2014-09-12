. $(dirname ${BASH_SOURCE[0]})/bashrc

set -o vi
[[ -f $(dirname ${BASH_SOURCE[0]})/bin/tmuxinator.bash ]] && source $(dirname ${BASH_SOURCE[0]})/bin/tmuxinator.bash
