#!/usr/bin/env bash

for file in `ls *.nix`
do
  if [[ $file == "darwin-configuration.nix" ]]
  then
    continue
  fi
  echo "Testing $file"
  nix-shell "$file" --run "nix-info -m"

done
