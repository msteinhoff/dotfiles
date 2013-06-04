#!/bin/bash
# default repository location
DF=~/Work/Personal/dotfiles

echo ""
echo "Installing dotfolders to $HOME"

cd $HOME
for source in `ls "$DF/folders/"`;
do
  dotfolder="$HOME/.$source"
  expected_target=$(cat "$DF/folders/$source")

  # file does not exist
  if [ ! -e "$dotfolder" ]
  then
    echo "-> Creating and linking $dotfolder to $expected_target"
    mkdir -p "$expected_target"
    ln -s "$expected_target" "$dotfolder"
    continue
  fi

  # File exist and is a link
  if [ -L "$dotfolder" ]
  then
    actual_target=$(readlink "$dotfolder")

    if [ "x$actual_target" == "x$expected_target" ]
    then
      echo "-> $dotfolder is okay (points to $expected_target)"
    else
      echo "-> Repairing $dotfolder because it points to $actual_target but should point to $expected_target"
      ln -s -f "$expected_target" "$dotfolder"
    fi
    continue
  fi

  # File exist and is a folder
  if [ -d "$dotfolder" ]
  then
    if [ "x$expected_target" = "xnoop" ]
    then
      echo "-> $dotfolder is okay (should be left as is)"
      continue
    fi
    
    if [ -d "$expected_target" ]
    then
      echo "-> Skipping movable $dotfolder because target $expected_target already exists."
      continue
    fi

    echo "-> Moving $dotfolder to $expected_target"
    mv "$dotfolder" "$expected_target"
    ln -s "$expected_target" "$dotfolder"
    continue 
  fi

  # Fuck this shit
  echo "-> Can not handle $dotfolder"
done

echo ""
