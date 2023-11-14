{ pkgs ? import <nixpkgs> {} }:

let
  my-python-packages = ps: with ps; [
    pandas
    jupyter
    rdkit
    matplotlib
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
    (
      buildPythonPackage rec {
        pname = "pyteomics";
        version = "4.6.3";
        src = fetchPypi {
          inherit pname version;
          sha256 = "sha256-47sR5X2j5SynaNlP7RLJ9m1zAP1YvMvGc238Bwf9lUY=";
        };
        doCheck = false;
        propagatedBuildInputs = [
        ];
      }
    )
  ];
  my-python = pkgs.python3.withPackages my-python-packages;
in my-python.env
