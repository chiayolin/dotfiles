# system
alias rsync="rsync --partial --progress --human-readable --compress"
alias less="less --ignore-case --raw-control-chars"
alias mkdir="mkdir -vp"
alias cp="cp -irv"
alias rm="rm -iv"
alias mv="mv -iv"
alias df="df -H"

# git
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
function gshn() {
	([ -z "$1" ] || [ $(($1)) -lt 0 ]) && echo 'Invalid integer!' && return
		git show HEAD@{$1}
}

