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
  # do something...

# if the machine is running on OSX
elif [ $DARWIN ]; then
  export LC_ALL=en_US.UTF-8
  export PATH="/usr/local/sbin:$PATH"

# if the machine is running on Windows
elif [ $WINDOWS ]; then
  # do something
fi
