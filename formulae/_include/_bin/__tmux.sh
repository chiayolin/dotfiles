#!/bin/bash
# this tmux script is inspired by @andrewratliff's tm.sh:
# <https://github.com/andrewratliff/dotfiles/blob/master/bin/tm.sh>

# exit if we are already in a tmux session
[ "$TMUX" == "" ] || exit 0

array_options=($(tmux list-sessions -F "#S" 2> /dev/null)
  "new session" "default shell")

_exit_error () {
  (2>&1 echo "Invalid $1, using defualt shell...")
  exit 1
}

_exit_defualt () {
  echo "Using defualt shell..."
  exit 0
}

# print a list of otions
echo "List of available sessions:"
array_length=${#array_options[@]}
for ((i=0; i<$array_length; i++)); do 
  echo "$i) ${array_options[$i]}"
done

# get a choice from user
echo ""; read -p "Choose your session: " choice 
if [[ "$((choice))" != "$choice" ]]; then
  [ -z "$choice" ] && _exit_defualt
  _exit_error "char(s)"
elif [ -z "$choice" ] || [ "$choice" -gt "$array_length" ]; then
  _exit_error "session"
fi

case ${array_options[$choice]} in
  "new session")
    read -p "Enter new session name: " session_name
    [ -z "$session_name" ] && _exit_error "session name"
    tmux new -s "$session_name"
    ;;
  "default shell")
    ;;
  *)
    tmux attach-session -t "${array_options[$choice]}"
    ;;
esac
exit 0
