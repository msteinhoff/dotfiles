#!/bin/bash
# default repository location
DF=~/Work/Personal/dotfiles
DB=~/.dotbackup

echo ""
echo "Installing dotfiles to $HOME"

function getlink
{
  echo `python -c 'import os,sys;print os.path.realpath(sys.argv[1])' $1`
}

mkdir $DB
for source in `ls "$DF/files/"`;
do
  dotfile="$HOME/.$source"

  needlink="yes"
  if [ -f "$dotfile" ] || [ -h "$dotfile" ]
  then
    if [ ! -h $DF/files/$source ];
    then
      diff "$DF/files/$source" "$dotfile"
      SAME=$?
    else
      AL=`getlink $DF/files/$source`
      BL=`getlink $dotfile`

      if [  "$AL" = "$BL" ];
      then
        SAME=0
      else
        SAME=1
      fi
    fi

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
    if [ ! -h $DF/files/$source ];
    then
      echo "-> Installing $DF/files/$source to $dotfile"
      ln -s -f $DF/files/$source $dotfile
    else
      RP=$(getlink $DF/files/$source)
      echo "-> Installing $RP to $dotfile"
      ln -s -f $RP "$dotfile"
    fi
    echo ""
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
