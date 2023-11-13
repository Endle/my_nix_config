{ pkgs ? import <nixpkgs> {} }:

let
  my-python-packages = ps: with ps; [
    pandas
    jupyter
    rdkit
    (
      buildPythonPackage rec {
        pname = "spectrum_utils";
        version = "0.4.2";
        src = fetchPypi {
          inherit pname version;
          sha256 = "sha256-egIS8StncMWSGE9OgvS3ux8RC02yo7kUobSy8/jHlpM=";
        };
        doCheck = false;
        propagatedBuildInputs = [
          # Specify dependencies
          #pkgs.python3Packages.numpy
        ];
      }
    )
  ];
  my-python = pkgs.python3.withPackages my-python-packages;
in my-python.env
