#!/bin/bash
# default repository location
DF=~/Work/Personal/dotfiles
DB=~/.dotbackup

echo ""
echo "Installing dotfiles to $HOME"

mkdir $DB
for source in `ls "$DF/files/"`;
do
  dotfile="$HOME/.$source"

  needlink="yes"
  if [ -e "$dotfile" ]
  then
    diff "$DF/files/$source" "$dotfile"

    if [ "$?" -eq "0" ]
    then
        needlink="no"
        echo "-> $dotfile is okay"
    else
        echo "-> Different $dotfile file exists, moving to DB"
        mv "$dotfile" "$DB"
    fi
  fi

  if [ "x$needlink" == "xyes" ]
  then
    echo "-> Installing $DF/files/$source to $dotfile"
    ln -s -f "$DF/files/$source" "$dotfile"
  fi
done

if [ "x$(ls -A $DB)" == "x" ];
then
    rm -rf "$DB"
    true
else
    echo "Some files were backed up to $DB"
fi

echo ""
