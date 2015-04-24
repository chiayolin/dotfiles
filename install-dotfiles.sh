#!/bin/sh
DOTFILESDIR=$(pwd -P)

for DOTFILE in *; do
  HOMEFILE="$HOME/.$DOTFILE"

  # if dotfile is a directory
  [ -d $DOTFILE ] && DOTFILE="$DOTFILE/"
	
  # get full path
  DIRFILE="$DOTFILESDIR/$DOTFILE"
	
  # skip non dotfiles and old files with *.old
  echo $DOTFILE | egrep -q '(dotfiles|\.txt|\.md|\.old)' \
    && continue
	
  # get *.sh files, remove it. then add a dot in front.
  echo $DOTFILE | grep -q '\.sh' \
    && HOMEFILE="$HOME/.$(echo $DOTFILE | sed -e 's/\.sh//')"
	
  # make symbolic links to ~/
  if [ -L "$HOMEFILE" ] && ! [ -d $DOTFILE ]; then
    ln -sfv "$DIRFILE" "$HOMEFILE"
  else
    [ -e "$HOMEFILE" ] && rm -rv "$HOMEFILE"
    ln -sv "$DIRFILE" "$HOMEFILE"
  fi
done
