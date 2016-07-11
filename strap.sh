#/bin/sh

DOTFLE_DIR="formulae"
ORIGIN_DIR=$(pwd -P)
PROGM_NAME=$(basename "$0")


install_dotfiles () {
  cd ./$DOTFLE_DIR
  for dotfile in *; do
    # get the full path and init variables
    dotfile_target="$HOME/.$dotfile"
    
    # check if it's a directory
    [ -d $dotfile ] && dotfile="$dotfile/"
    dotfile_origin="$ORIGIN_DIR/$DOTFLE_DIR/$dotfile"

    # skip non-dotfiles
    echo $dotfile | egrep -q '($PROGM_NAME|\.txt|\.md)' \
      && continue

    # remove extension from *.sh, and make it a dotfile
    echo $dotfile | grep -q '\.sh' \
      && dotfile_target="$HOME/.$(echo $dotfile | sed -e 's/\.sh//')"

    # install a dotfile by symlinking it
    if [ -L "$dotfile_target" ] && ! [ -d $dotfile ]; then
      ln -sfv "$dotfile_origin" "$dotfile_target"
    else
      [ -e "$dotfile_target" ] && rm -rv "$dotfile_target"
      ln -sv "$dotfile_origin" "$dotfile_target"
    fi
  done
  cd ..
}

uninstall_dotfiles () {
  # remove the symlinks to $ORIGIN_DIR at $HOME
  rm -fv $(find $HOME -type l -ls -maxdepth 1 | \
    grep "$ORIGIN_DIR" | awk '{ print $11 }' | xargs)
}

fetch_update () {
  # fetch the latest update
  [ -d "$ORIGIN_DIR/.git" ] && \
    git --work-tree="$ORIGIN_DIR" --git-dir="${ORIGIN_DIR}/.git" pull \
      --recurse-submodules=yes origin master && git submodule init && \
        git submodule update
}

_write_stderr () {
  2>&1 echo "$PROGM_NAME: error: $1"
}

error_handling () {
  local prefix="failed to"
  local suffix="dotfiles"
  case $1 in
    3) _write_stderr "$prefix install $suffix"
      ;;
    4) _write_stderr "$prefix uninstall $suffix"
      ;;
    5) _write_stderr "$prefix update $suffix"
      ;;
    *) _write_stderr "unknown error(s) :(" 
  esac

  exit 1
}

main () {
  if [ $1 == "install" ]; then
    echo "installing dotfiles..."
    install_dotfiles || return 3
  
  elif [ $1 == "uninstall" ]; then
    echo "uninstalling dotfiles..."
    uninstall_dotfiles || return 4
  
  elif [ $1 == "update" ]; then
    echo "fetching updates..."
    fetch_update || return 5
  
  else
    echo "unknown option" || return 6
  fi
}

# get the last argument and pass it to main
for argv; do : ; done
main ${argv} || error_handling $?
echo "done."
