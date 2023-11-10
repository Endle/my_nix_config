 let
   nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.05";
   pkgs = import nixpkgs { config = { allowUnsupportedSystem = true; }; overlays = []; };
 in
  pkgs.mkShell {

    nativeBuildInputs = with pkgs.buildPackages; [ 
      texstudio
      texlive.combined.scheme-full
    ];

}


