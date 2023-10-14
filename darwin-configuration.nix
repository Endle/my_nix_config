{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ 
	pkgs.git
	pkgs.htop
	pkgs.eza
	pkgs.ripgrep

  # make lunarvim happy
  pkgs.clangStdenv 
  pkgs.gnumake 

	pkgs.neovim


	pkgs.wezterm

	pkgs.sioyek
	pkgs.libreoffice-bin
# mpv buggy now: https://matrix.to/#/!lheuhImcToQZYTQTuI:nixos.org/$ZsUQH38c1LkOph_y1Jh4yVMgekP_Pg8iwYumSl8VFeE?via=nixos.org&via=matrix.org&via=nixos.dev
	pkgs.mpv
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = false;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
