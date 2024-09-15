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

  outputs = inputs@{ self, nix-darwin, nixpkgs, lix-module }: let configuration = { pkgs, ... }:
  {

    environment.systemPackages = [
        # Code Management
        pkgs.git
        pkgs.git-lfs
        pkgs.mercurial
        pkgs.meld #not configured yet
        pkgs.difftastic #not applied to git yet

        # Bash tools
        pkgs.coreutils-full

        pkgs.htop pkgs.btop pkgs.wget pkgs.eza
        pkgs.ripgrep pkgs.fd
        pkgs.trash-cli

        pkgs.sccache
        pkgs.libiconv # needed by almost all rust projects

        # fractal pre-commit check
        #pkgs.typos
        #pkgs.cargo-sort
        pkgs.rustup

        pkgs.neovim
        pkgs.tree-sitter
        pkgs.ctags

        pkgs.qemu
        pkgs.podman
        pkgs.lima
        pkgs.utm

        # Terminal
        pkgs.yazi
        pkgs.wezterm
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
            pkgs.mpv
    ];



      services.nix-daemon.enable = true;

      nix.settings.experimental-features = "nix-command flakes";

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
