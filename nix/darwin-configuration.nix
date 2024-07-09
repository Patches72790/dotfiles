{ config, pkgs, ... }:


{
  imports = [
    <home-manager/nix-darwin>
    ./modules/dock
  ];

  users.users.plharvey = {
    name = "plharvey";
    home = "/Users/plharvey";
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
    ];

  home-manager.users.plharvey = { pkgs, ... }: {
    # Wtf terraform?
    nixpkgs.config = {
      allowUnfree = true;
    };

    home.packages = with pkgs; [
      neovim
      temurin-bin-21
      maven
      deno
      nodejs_20
      python311
      alacritty
      terraform
      go
    ];

    home.stateVersion = "24.05";
  };

  programs.tmux.enable = true;
  programs.tmux.enableFzf = true;
  programs.tmux.enableSensible = true;
  programs.tmux.enableVim = true;

  programs.tmux.extraConfig = ''
    set -s escape-time 10
    set -s focus-events on
    set -g mouse on
    set -g history-limit 100000
    set-window-option -g mode-keys vi

    # Set control + space to prefix key
    unbind C-b
    set -g prefix C-Space

    # Quick binding for reloading config with prefix + r
    unbind r
    bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded tmux config"

    # set bindings for pane splits
    unbind v
    unbind h
    unbind n 
    unbind w

    unbind % # Split vertically
    unbind '"' # Split horizontally

    bind v split-window -h -c "#{pane_current_path}"
    bind h split-window -v -c "#{pane_current_path}"
    bind w new-window -c "#{pane_current_path}"
    bind n command-prompt "rename-window '%%'"

    ## By using vim keys
    bind -n C-h select-pane -L
    bind -n C-j select-pane -D
    bind -n C-k select-pane -U
    bind -n C-l select-pane -R
  '';

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

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
      { path = "${pkgs.alacritty}/Applications/Alacritty.app/"; }
      { path = "/Applications/iTerm.app/"; }
      { path = "/Applications/Firefox.app/"; }
      { path = "/Applications/Anki.app/"; }
      { path = "/Applications/Microsoft Outlook.app/"; }
      { path = "/Applications/Microsoft Teams.app/"; }
    ];
  };


  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
