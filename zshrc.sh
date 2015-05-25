# load shared shell configuration
source ~/.shrc

# enable completions
autoload -U compinit && compinit

# enable regex moving
autoload -U zmv

# style ZSH output
zstyle ':completion:*:descriptions' format '%U%B%F{red}%d%f%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# don't show duplicate history entires
setopt hist_find_no_dups

# remove unnecessary blanks from history
setopt hist_reduce_blanks

# share history between instances
setopt share_history

# don't hang up background jobs
setopt no_hup

# expand parameters, commands and aritmatic in prompts
setopt prompt_subst

# colorful prompt with Git branch
autoload -U colors && colors

git_branch() {
  GIT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  [ -n "$GIT_BRANCH" ] && echo "($GIT_BRANCH) "
}

if [ $USER = "root" ]
then
  PROMPT='%{$fg_bold[magenta]%}%m %{$fg_bold[blue]%}# %b%f'
elif [ -n "${SSH_CONNECTION}" ]
then
  PROMPT='%{$fg_bold[cyan]%}%m %{$fg_bold[blue]%}# %b%f'
else
  PROMPT='%{$fg_bold[green]%}%m %{$fg_bold[blue]%}# %b%f'
fi
RPROMPT='%{$fg_bold[red]%}$(git_branch)%{$fg_bold[yellow]%}$(svn_branch)%b[%{$fg_bold[blue]%}%~%b%f]'

# history file
export HISTFILE=~/.zsh_history

# more OSX/Bash-like word jumps
export WORDCHARS=''

# fix backspace on Debian
[ $LINUX ] && bindkey "^?" backward-delete-char

# fix delete key on OSX
[ $OSX ] && bindkey "\e[3~" delete-char

# alternate mappings for Ctrl-U/V to search the history
bindkey "^u" history-beginning-search-backward
bindkey "^v" history-beginning-search-forward
