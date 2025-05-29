{ config
, pkgs
, unstable
, lib
, ...
}:

{
  nix = {
    enable = true;
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

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

  environment.variables = {
    EDITOR = "nvim";
  };

  programs.zsh.shellInit = ''
    function trassh {
        TOKEN=$(op read op://trad/svc-acct-gitlab-runner-1pass/credential)
        OP_TOKEN=$TOKEN ssh-at-trad $@
    }
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
