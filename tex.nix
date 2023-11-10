 let
   nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-22.11";
   pkgs = import nixpkgs { config = { allowUnsupportedSystem = true; }; overlays = []; };
   # nixpkgs.config.allowUnsupportedSystem = true;
   # allowUnsupportedSystem = true;
 in
  pkgs.mkShell {
    # NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1;
    nativeBuildInputs = with pkgs.buildPackages; [ 
      texstudio

    ];

}


