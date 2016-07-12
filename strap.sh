#/bin/sh
#
# NAME
#   strap.sh - bootstrap your development env.
#
# PURPOSE
#   this is the main script of my dotfiles repository for installing 
#   the dotfiles and packages that are usually installed on my mach-
#   ine. see README.md under this directory for more information ab-
#   out the directory structure.
#
# USAGE
#   sh strap.sh [options]
#   options:  
#     show           show repo's remote source
#     update         fetch the latest update(s)
#     install        installl dotfiles to \$HOME
#     uninstall      uninstall dotfiles from \$HOME
#     install-pkg    install packages to the mchine
#     uninstall-pkg  uninstall packages from the machine
#
#    example:
#       $ sh strap.sh install
#
#     run `sh strap.sh` without any additional aruguments to ptint 
#     out the help message
#
# AUTHOR
#   Chiayo Lin <chiayo.lin@gmail.com>
#   <https://github.com/chiayolin/dotfiles>
#
# LICENSE
#   this file is licensed under the MIT License.

# init
PACKGE_DIR="packages"
DOTFLE_DIR="formulae"
ORIGIN_DIR=$(pwd -P)
PROGM_NAME=$(basename "$0")

# get operating system type
[ "$(uname -s)" == "Darwin" ] && OPSYS_NAME="darwin"
SUPPORTED_PKGS=$(find $PACKGE_DIR -type f -name "*.$OPSYS_NAME")

# define errnos
# INSTERR - installation error
# UISTERR - uninstallation error
# UPDTERR - update error
# RSRCERR - git remote show origin error
# IPKGRRR - package installation error
# UPKGERR - package uninstallation error
# UKNOERR - unknown error(s)
INSTERR=3; UISTERR=4; UPDTERR=5; 
RSRCERR=6; IPKGRRR=7; UPKGERR=8;
UKNOERR=9; SUCCESS=0;

# general function writting to stdout
_write_stdout () {
  echo "$PROGM_NAME: $1"
}

# general function writting to stderr
_write_stderr () {
  (2>&1 echo "$PROGM_NAME: error: $1")
}

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
  cd $ORIGIN_DIR
}

uninstall_dotfiles () {
  # remove the symlinks to $ORIGIN_DIR at $HOME
  rm -fv $(find $HOME -type l -ls -maxdepth 1 | \
    grep "$ORIGIN_DIR" | awk '{ print $11 }' | xargs)
}

install_packages () {
  for package in $SUPPORTED_PKGS; do
    _write_stdout "installing $ORIGIN_DIR/$package..."   
    source $(echo $package | sed -e "s/\.$OPSYS_NAME//").info && \
      source $package install
  done
}

uninstall_packages () {
  _write_stdout "please uninstall the installed packages manually."
}

fetch_update () {
  # fetch the latest update
  [ -d "$ORIGIN_DIR/.git" ] && \
    git --work-tree="$ORIGIN_DIR" --git-dir="${ORIGIN_DIR}/.git" pull \
      --recurse-submodules=yes origin master && git submodule init && \
        git submodule update
}

_error_handling () {
  local prefix="failed to"
  local suffix="dotfiles"
  case $1 in
    3) _write_stderr "$prefix install $suffix"
      ;;
    4) _write_stderr "$prefix uninstall $suffix"
      ;;
    5) _write_stderr "$prefix update $suffix"
      ;;
    6) _write_stderr "$prefix determine repo's remote source"
      ;;
    7) _write_stderr "invalid option: $ARG"
       echo && print_help
      ;;
    # put the installing error thingy here too
    *) _write_stderr "unknown error(s) :("
      ;;
  esac

  exit 1
}

print_help () {
  echo "usage: $PROGM_NAME [option]"
  echo "options:"
  echo "  show           show repo's remote source"
  echo "  update         fetch the latest update(s)"
  echo "  install        installl dotfiles to \$HOME"
  echo "  uninstall      uninstall dotfiles from \$HOME"
  echo "  install-pkg    install packages to the mchine"
  echo "  uninstall-pkg  uninstall packages from the machine"
}

main () {
  if [ -z $1 ]; then
    print_help && exit $SUCCESS
  elif [ $1 == "install" ]; then
    _write_stdout "installing dotfiles..."
    install_dotfiles || return 3
  
  elif [ $1 == "uninstall" ]; then
    _write_stdout "uninstalling dotfiles..."
    uninstall_dotfiles || return 4
  
  elif [ $1 == "update" ]; then
    _write_stdout "fetching updates..."
    fetch_update || return 5

  elif [ $1 == "show" ]; then
    _write_stdout "determining repo's remote origin..."
    git remote show origin || return 6
  
  elif [ $1 == "install-pkg" ]; then
    install_packages || return 7
  
  elif [ $1 == "uninstall-pkg" ]; then
    uninstall_packages || return 8
  
  else
    return 9
  fi
}

# get the last argument and pass it to main
for ARGV; do : ; done && ARG=${ARGV}
main $ARG || _error_handling $?
