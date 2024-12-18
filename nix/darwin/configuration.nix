{ config
, pkgs
, ...
}:

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in
{
  imports = [
    <home-manager/nix-darwin>
    ./modules/dock
  ];

  users.users.plharvey = {
    name = "plharvey";
    home = "/Users/plharvey";
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true; #for julia? 
    packageOverrides = pkgs: {
      unstable = import unstableTarball
        { config = config.nixpkgs.config; };
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs; [
      vim
      curl
      direnv
      jq
      htop
      fd
      fzf
      ripgrep
      git
      awscli
      tomcat10
      sshpass
      tree
      pkgs.unstable.sshfs
      graphviz
    ];

  home-manager.users.plharvey = { pkgs, ... }: {
    # Wtf terraform?
    nixpkgs.config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        unstable = import unstableTarball
          { config = config.nixpkgs.config; };
      };
    };

    home.packages = with pkgs; [
      pkgs.unstable.neovim
      jdk21_headless
      maven
      deno
      nodejs_20
      python312
      pkgs.unstable.alacritty
      terraform
      pkgs.unstable.go
      pkgs.unstable.rustup
      sqlite
      obsidian
      iterm2
      stack
      ghc
    ];

    home.stateVersion = "24.11";
  };

  programs.tmux.enable = true;
  programs.tmux.enableFzf = true;
  programs.tmux.enableSensible = true;
  programs.tmux.enableVim = true;

  programs.tmux.extraConfig = ''
    source-file -q ~/.config/tmux/tmux.conf
  '';

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nix/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  programs.zsh.enableBashCompletion = true;
  programs.zsh.enableFzfCompletion = true;
  programs.zsh.enableFzfGit = true;
  programs.zsh.enableFzfHistory = true;

  programs.zsh.shellInit = ''
    source $HOME/.zshrc
  '';

  local.dock = {
    enable = true;
    entries = [
      { path = "${pkgs.iterm2}/Applications/iTerm2.app/"; }
      { path = "${pkgs.obsidian}/Applications/Obsidian.app/"; }
      { path = "/Applications/Firefox.app/"; }
      { path = "/Applications/Anki.app/"; }
      { path = "/Applications/Microsoft Outlook.app/"; }
      { path = "/Applications/Microsoft Teams.app/"; }
    ];
  };


  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
