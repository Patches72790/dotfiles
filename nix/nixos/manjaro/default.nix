{ config, pkgs, unstable, system, lib, ... }:

let
  nixGL = import ./util/nixgl.nix { inherit pkgs config lib; };
in
{
  imports = [
    ./zsh
    ./options
  ];

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
    (nixGL unstable.blender)
    (nixGL unstable.alacritty)
    nixgl.auto.nixGLDefault
    #(nixGL unstable.obs-studio)
    unstable.haskellPackages.xmonad

    unstable.nodejs_24
    unstable.ghc
    unstable.haskellPackages.haskell-language-server
    unstable.haskellPackages.stack
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
  };

  home.sessionVariables = {
    EDITOR = "nvim ";
  };

  programs.home-manager.enable = true;
}
