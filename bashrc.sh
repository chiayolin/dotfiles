# include shared shell configuraion
source ~/.shrc

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

# sexy prompt
if [ $USER = "root" ]; then
  PS1='\[\033[01;35m\]\h\[\033[01;34m\] \W #\[\033[00m\] '
elif [ -n "${SSH_CONNECTION}" ]; then
  PS1='\[\033[01;36m\]\h\[\033[01;34m\] \W #\[\033[00m\] '
else
  PS1='\[\033[01;32m\]\h\[\033[01;34m\] \W #\[\033[00m\] '
fi

# history
export HISTCONTROL=ignoredups
export PROMPT_COMMAND='history -a'
export HISTIGNORE="&:ls:[bf]g:exit"
