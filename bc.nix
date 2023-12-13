{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [ 
      beancount
      fava

      python311
      python311Packages.pandas
      python311Packages.titlecase
      python311Packages.numpy

    ];
}

