{ config, pkgs, nixpkgs, unstable, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "patroclus";
  home.homeDirectory = "/home/patroclus";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    unstable.nodejs_22
    unstable.neovim
    unstable.python313
    unstable.rustup
    unstable.discord
    unstable.go
    sqlite
    ripgrep
    fzf
    fd
    jdk21_headless
    unstable.inkscape-with-extensions
    unstable.gimp
    unstable.firefox
    unstable.vscode
    unstable.sunshine
    unstable.blender
    unstable.obs-studio
  ];

  programs.git = {
    enable = true;
    userName = "patches72790";
    userEmail = "patches72790@gmail.com";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".vimrc".source = ./dotfiles/vimrc;
    ".config/tmux/tmux.conf".source = ./dotfiles/tmux.conf;
    ".config/alacritty/alacritty.toml".source = ./dotfiles/alacritty.toml;
    ".zshrc".source = ./dotfiles/zshrc;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/patroclus/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim ";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
