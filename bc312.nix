{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [ 
      beancount
      fava

      python312
      python312Packages.pandas
      python312Packages.titlecase
      python312Packages.numpy

    ];
}

