{ config
, pkgs
, unstable
, lib
, ...
}:

{
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs; [
      _1password-cli
      home-manager
      unstable.alacritty
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
      graphviz
      wireguard-go
      wireguard-tools
      git-crypt
      gnupg
      glab
      httpie
    ];

  programs.tmux.enable = true;
  programs.tmux.enableFzf = true;
  programs.tmux.enableSensible = true;
  programs.tmux.enableVim = true;

  programs.tmux.extraConfig = ''
    source-file -q ~/.config/tmux/tmux.conf
  '';

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  programs.zsh.enableBashCompletion = true;
  programs.zsh.enableFzfCompletion = true;
  programs.zsh.enableFzfGit = true;
  programs.zsh.enableFzfHistory = true;

  programs.zsh.shellInit = ''
    source $HOME/.zshrc
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
