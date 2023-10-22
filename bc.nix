{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [ 
      beancount
      fava

      python310
      python310Packages.pandas
      python310Packages.titlecase

    ];
}

