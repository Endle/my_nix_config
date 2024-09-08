{
    description = "Zhenbo Darwin system flake";

    inputs = {
        lix-module = {
              url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
              inputs.nixpkgs.follows = "nixpkgs"; 
        };

        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nix-darwin.url = "github:LnL7/nix-darwin";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = inputs@{ self, nix-darwin, nixpkgs, lix-module }:
  let
    configuration = { pkgs, ... }: {

  environment.systemPackages =
    [ 

# Code Management

    pkgs.git
    pkgs.git-lfs
    pkgs.mercurial
    pkgs.meld #not configured yet
    pkgs.difftastic #not applied to git yet



# Bash tools
    pkgs.coreutils-full

    pkgs.htop
    pkgs.btop
    pkgs.wget
    pkgs.eza
    pkgs.ripgrep
    pkgs.fd

    pkgs.sccache
    pkgs.libiconv # needed by almost all rust projects

    # fractal pre-commit check
    #pkgs.typos
    #pkgs.cargo-sort

# Dev tools
#    pkgs.gcc13
#    pkgs.gnumake

    pkgs.rustup


#    pkgs.lunarvim
    pkgs.neovim
    pkgs.ctags
#    pkgs.python3 # make lunarvim happy
#    pkgs.tree-sitter # make lunarvim happy

    pkgs.qemu
    pkgs.podman
    pkgs.lima
    pkgs.utm


    # Terminal
    pkgs.yazi
    pkgs.wezterm
    pkgs.trash-cli

    # TODO not configured yet
    pkgs.atuin #https://github.com/atuinsh/atuin#shell-plugin


# Sys tools
  pkgs.smartmontools


  pkgs.nix-index


# Applications


  pkgs.ArchiSteamFarm

	pkgs.sioyek
	pkgs.libreoffice-bin
  pkgs.inkscape
# mpv buggy now: https://matrix.to/#/!lheuhImcToQZYTQTuI:nixos.org/$ZsUQH38c1LkOph_y1Jh4yVMgekP_Pg8iwYumSl8VFeE?via=nixos.org&via=matrix.org&via=nixos.dev
	pkgs.mpv
	pkgs.jellyfin
    ];


      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Zhenbos-Mac-mini
    darwinConfigurations."Zhenbos-Mac-mini" = nix-darwin.lib.darwinSystem {
      modules = [ configuration 
      lix-module.nixosModules.default
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Zhenbos-Mac-mini".pkgs;
  };
}
