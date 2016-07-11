#!/bin/sh

# save more history
export HISTSIZE=100000
export SAVEHIST=100000

# OS variables
OS="$(uname -s)"
[ $OS = "Darwin" ] && export OSX=1 && export UNIX=1 
[ $OS = "Linux" ] && export LINUX=1 && export UNIX=1
uname -s | grep -q "_NT-" && WINDOWS=1

# colorful man
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# aliases
source ~/.aliases

# save current path dynamically
trap 'pwd > ~/.lastpwd' DEBUG

# platform-specific stuffs
if [ $LINUX ]; then
  # colorful ls
  alias ls='ls --color=auto'

  # ibus input
  export GTK_IM_MODULE=ibus
  export XMODIFIERS=@im=ibus
  export QT_IM_MODULE=ibus

elif [ $OSX ]; then
  export LC_ALL=en_US.UTF-8
  export PATH="/usr/local/sbin:$PATH"

  # check if thefuck exists
  [ "$(which thefuck)" ] && \
    eval "$(thefuck --alias)"

  # brew update and upgrade
  [ "$(which brew)" ] && \
    alias buu='brew update && brew upgrade --all'
  
  #  mit-scheme silent shortcut: scm
  if [ "$(which scheme)" ]; then
    scm() {
      [ $# -eq 0 ] && \
        >&2 echo "scm: error: no input files" \
          && return 1
      scheme --silent < "$*"
    }
  fi

  # figlet thingy
  # figlet "Occupy  Mars"

elif [ $WINDOWS ]; then
  # clear command for cygwin
  alias clear='printf "\033c"'
fi