{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ 

# Code Management
	pkgs.git
  pkgs.git-lfs
  pkgs.mercurial



# Bash tools
	pkgs.htop
  pkgs.wget
	pkgs.eza
	pkgs.ripgrep
	pkgs.fd

  # pkgs.darwin.xcode_12_3


# Dev tools
	pkgs.tree-sitter # make lunarvim happy
  pkgs.gcc
  pkgs.gnumake

	pkgs.neovim


# Terminal
  pkgs.yazi
	pkgs.wezterm

# Applications

  pkgs.utm

	pkgs.sioyek
	pkgs.libreoffice-bin
  pkgs.inkscape
# mpv buggy now: https://matrix.to/#/!lheuhImcToQZYTQTuI:nixos.org/$ZsUQH38c1LkOph_y1Jh4yVMgekP_Pg8iwYumSl8VFeE?via=nixos.org&via=matrix.org&via=nixos.dev
	pkgs.mpv
    ];


  # nixpkgs.config.allowUnfree = true; # For xcode


  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = false;  # default shell on catalina

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

}
