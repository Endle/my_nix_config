{ config,  pkgs, ... }:

let
  unstable = import <unstable> {
    config = config.nixpkgs.config; 
  };
  forcepkgs = import <unstable> { 
    config = { allowUnsupportedSystem = true; }; overlays = []; 
  };
in
{
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

  # pkgs.darwin.xcode_13_4_1


# Rust
  pkgs.rustc
  pkgs.cargo
  pkgs.rustfmt
  pkgs.clippy
  pkgs.sccache
  pkgs.libiconv # needed by almost all rust projects
  # fractal pre-commit check
  pkgs.typos
  pkgs.cargo-sort

# Dev tools
  pkgs.gcc13
  pkgs.gnumake


  pkgs.lunarvim
  pkgs.neovim
  pkgs.python3 # make lunarvim happy
	pkgs.tree-sitter # make lunarvim happy

  pkgs.qemu
  pkgs.podman
  unstable.lima


# Terminal
  pkgs.yazi
	pkgs.wezterm

# TODO not configured yet
  pkgs.atuin #https://github.com/atuinsh/atuin#shell-plugin


# Sys tools
  pkgs.smartmontools


  pkgs.nix-index


# Applications


  unstable.ArchiSteamFarm

	pkgs.sioyek
	pkgs.libreoffice-bin
  pkgs.inkscape
# mpv buggy now: https://matrix.to/#/!lheuhImcToQZYTQTuI:nixos.org/$ZsUQH38c1LkOph_y1Jh4yVMgekP_Pg8iwYumSl8VFeE?via=nixos.org&via=matrix.org&via=nixos.dev
	pkgs.mpv
	pkgs.jellyfin
    ];


  nixpkgs.config.allowUnfree = true; # For xcode


  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = false;  # default shell on catalina

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

}
