# system aliases
alias rsync="rsync --partial --progress --human-readable --compress"
alias less="less --ignore-case --raw-control-chars"
alias mkdir="mkdir -vp"
alias cp="cp -irv"
alias rm="rm -iv"
alias mv="mv -iv"
alias df="df -H"
alias bc="bc -lq"

# git aliases
## Git CLone
alias gcl='git clone'
## Git Pull (Get)
alias gget='git pull'
## Git Put (Push)
alias gput='git push'
## Git Status
alias gs='git status'
## Git ComMit Message
alias gcmm='git commit -m'
## Git SHow
alias gsh='git show'
## Git Show HEAD@{N}
gshn () {
  ([ -z "$1" ] || [ $(($1)) -lt 0 ]) && echo 'Invalid integer!' && return
  git show HEAD@{$1}
}

# platform-specific aliases
if [ $LINUX ]; then
  alias ls='ls --color=auto'

elif [ $DARWIN ]; then
  # `fuck` for `thefuck` if it's installed
  command -v thefuck >/dev/null 2>&1 && {
    eval "$(thefuck --alias)"
  }
  
  # `buu` to update and upgrade `brew` if `brew` exists
  command -v brew >/dev/null 2>&1 && {
    alias buu='brew update && brew upgrade'
  }

elif [ $WINDOWS ]; then
  # alias for the `clear` command at cygwin
  alias clear='printf "\033c"'
fi
