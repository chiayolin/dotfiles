## general shell configuration

# geting 256 colours to work in terminal
export TERM=screen-256color

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
  :

# if the machine is running on OSX
elif [ $DARWIN ]; then
  export LC_ALL=en_US.UTF-8
  export PATH="/usr/local/sbin:$PATH"
  # for coreutils
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# if the machine is running on Windows
elif [ $WINDOWS ]; then
  # do somethinga
  :
fi

# path to last pwd file
export LASTPWD=$HOME/.lastpwd

# load last pwd if file exists
if [[ -f $LASTPWD ]]; then
  cd "$(cat $LASTPWD)"
fi

# run tmux script if tmux is installed and $ENTER_DEFALUT_SHELL 
# is not set to 1 by the tmux script
if command -v tmux>/dev/null; then
  [ $ENTER_DEFAULT_SHELL ] && \
    $HOME/._include/_bin/__tmux.sh
  # prevent the script from running recursively
  export ENTER_DEFAULT_SHELL=1
fi
