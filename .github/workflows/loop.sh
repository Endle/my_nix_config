#!/usr/bin/env bash

echo "Current directory $(pwd) , file list $(ls) "

for file in `ls *.nix`
do
  if [[ $file == "darwin-configuration.nix" ]]
  then
    continue
  fi
  if [[ $file == "tex.nix" ]]
  then
    echo "Skip tex to save disk space. Exceed github limit"
    continue
  fi
  echo "Testing $file"
  nix-shell "$file" --run "nix --version"
done
