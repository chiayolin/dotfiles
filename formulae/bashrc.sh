# bashrc.sh - ~/.bashrc
# return if not running interactively
[ -z "$PS1" ] && return

# include common shell configuraion
source $HOME/._include/__shrc.sh

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# history file
export HISTFILE=~/.bash_history

# enable history appending instead of overwriting.
shopt -s histappend

# save multiline commands
shopt -s cmdhist

# correct spelling mistakes
shopt -s cdspell

# colourful prompt
if [ $USER = "root" ]; then
  PS1='\[\033[01;35m\]\h\[\033[01;34m\] \W #\[\033[00m\] '
elif [ -n "${SSH_CONNECTION}" ]; then
  PS1='\[\033[01;36m\]\h\[\033[01;34m\] \W #\[\033[00m\] '
else
  PS1='\[\033[01;32m\]\h\[\033[01;34m\] \W #\[\033[00m\] '
fi

# 2014 classic prompt
classic_prompt () {
  local \
    P_0="\e[00;37m┌[\[\e[0m\]\[\e[00;31m\]\u\[\e[0m\]\[\e[00;37m\]",
    P_1="@\[\e[0m\]\[\e[00;34m\]\h\[\e[0m\]\[\e[00;37m\]]-[\[\e[0m\]\[\e[00;33m\]",
    P_2="\$?\[\e[0m\]\[\e[00;37m\]]: \[\e[0m\]\[\e[00;36m\]\w\[\e[0m\]\[\e[00;37m\]",
    P_3="\n└─[\[\e[0m\]\[\e[00;32m\]\@\[\e[0m\]\[\e[00;37m\]]\\$ \[\e[0m\]"
    export PS1="$P_0$P_1$P_2$P_3"
}

# history
export HISTCONTROL=ignoredups
export PROMPT_COMMAND='history -a'
export HISTIGNORE="&:ls:[bf]g:exit"
