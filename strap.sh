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
# IPKGERR - package installation error
# UPKGERR - package uninstallation error
# IOPTERR - invalid option
# UKNOERR - unknown error(s)
INSTERR=3; UISTERR=4; UPDTERR=5; 
RSRCERR=6; IPKGERR=7; UPKGERR=8;
IOPTERR=9; UKNOERR=10; SUCCESS=0; FAILURE=1

# _write_stdout - a general function writting to stdout
_write_stdout () {
  echo "$PROGM_NAME: $1"
}

# _write_stderr - a general function writting to stderr
_write_stderr () {
  (2>&1 echo "$PROGM_NAME: error: $1")
}

_prompt_option () {
  printf "$PROGM_NAME: do you want do continue (y/n)? "

  local old_stty_config=$(stty -g)
  stty raw -echo
  local _option=$(head -c 1)
  stty $old_stty_config # restore old stty config
  echo ""
  
  $(echo "$_option" | grep -iq "^y") && return 0
  _write_stdout "package installation canceled, aborting..."
  return 1
}

# install_dotfiles - install the dotfiles within $DOTFLE_DIR
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

# install_dotfiles - uninstall the dotfiles under $HOME
uninstall_dotfiles () {
  # remove the symlinks to $ORIGIN_DIR at $HOME
  rm -fv $(find $HOME -type l -ls -maxdepth 1 | \
    grep "$ORIGIN_DIR" | awk '{ print $11 }' | xargs)
}

# install_packages - install $SUPPORTED_PKGS by following the rules 
#                    defined under $PACKGE_DIR
install_packages () {
  _write_stdout "the following packages will be installed:"
  for package in $SUPPORTED_PKGS; do echo "  $package"; done
  _prompt_option || exit $SUCCESS

  for package in $SUPPORTED_PKGS; do
    _write_stdout "fetching $ORIGIN_DIR/$package..."   
    source $(echo $package | sed -e "s/\.$OPSYS_NAME//").info && \
      source $package install
  done
}

# uninstall_packages - uninstall the packages installed
uninstall_packages () {
  _write_stdout "please uninstall the installed packages manually."
}

# fetch_update - fetch updates from remote source
fetch_update () {
  # fetch the latest update
  [ -d "$ORIGIN_DIR/.git" ] && \
    git --work-tree="$ORIGIN_DIR" --git-dir="${ORIGIN_DIR}/.git" pull \
      --recurse-submodules=yes origin master && git submodule init && \
        git submodule update
}

# _error_handling - handling error messages
_error_handling () {
  local prefix="failed to"
  local suffix="dotfiles"
  local suffix_pkg="packages"
  case $1 in
    $INSTERR) _write_stderr "$prefix install $suffix"
      ;;
    $UISTERR) _write_stderr "$prefix uninstall $suffix"
      ;;
    $UPDTERR) _write_stderr "$prefix update $suffix"
      ;;
    $RSRCERR) _write_stderr "$prefix determine repo's remote source"
      ;;
    $IPKGERR) _write_stderr "$prefix install $suffix_pkg"
      ;;
    $UPKGERR) _write_stderr "$prefix uninstall $suffix_pkg"
      ;;
    $IOPTERR) _write_stderr "invalid option: $ARG"
       echo && print_help
      ;;
    # put the installing error thingy here too
    *) _write_stderr "unknown error(s) :("
      ;;
  esac

  exit $FAILURE
}

# print_help - print help
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

# main - the good old main function
main () {
  if [ -z $1 ]; then
    print_help && exit $SUCCESS
  elif [ $1 == "install" ]; then
    _write_stdout "installing dotfiles..."
    install_dotfiles || return $INSTERR
  
  elif [ $1 == "uninstall" ]; then
    _write_stdout "uninstalling dotfiles..."
    uninstall_dotfiles || return $UISTERR
  
  elif [ $1 == "update" ]; then
    _write_stdout "fetching updates..."
    fetch_update || return $UPDTERR

  elif [ $1 == "show" ]; then
    _write_stdout "determining repo's remote origin..."
    git remote show origin || return $RSRCERR
  
  elif [ $1 == "install-pkg" ]; then
    install_packages || return $IPKGERR
  
  elif [ $1 == "uninstall-pkg" ]; then
    uninstall_packages || return $UPKGERR
  
  else
    return $UKNOERR
  fi
}

# get the last argument and pass it to main
for ARGV; do : ; done && ARG=${ARGV}
main $ARG || _error_handling $?
