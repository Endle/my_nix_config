#!/usr/bin/env bash

echo "Current directory $(pwd) , file list $(ls) "

for file in `ls *.nix`
do
  if [[ $file == "darwin-configuration.nix" ]]
  then
    continue
  fi
  echo "Testing $file"
  nix-shell "$file" --run "nix --version"
done
