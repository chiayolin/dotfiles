## general shell configuration
# save more history
export HISTSIZE=100000
export SAVEHIST=100000

# get the operating system type
_OS="$(uname -s)"
[ $_OS = "Darwin" ] && export DARWIN=1 && export UNIX=1 
[ $_OS = "Linux"  ] && export LINUX=1  && export UNIX=1
echo "$_OS" | grep -q "_NT-" && export WINDOWS=1

# display colourful manual pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# source the aliases
source $HOME/._include/__aliases.sh

## platform-specific configuration
# if the machine is running on Linux
if [ $LINUX ]; then
  # colourful ls
  alias ls='ls --color=auto'

# if the machine is running on OSX
elif [ $DARWIN ]; then
  export LC_ALL=en_US.UTF-8
  export PATH="/usr/local/sbin:$PATH"

  # configuration for `thefuck` if it's installed
  command -v thefuck >/dev/null 2>&1 && {
    eval "$(thefuck --alias)"
  }

# if the machine is running on Windows
elif [ $WINDOWS ]; then
  # the `clear` command for cygwin
  alias clear='printf "\033c"'
fi
