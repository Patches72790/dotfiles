{ config, pkgs, unstable, ... }: {

  imports = [
    ../manjaro/zsh
  ];

  home.packages = with pkgs; [
    unstable.obsidian
    unstable.vscode
    unstable.neovim
    unstable.jetbrains.idea-ultimate
    jdk21_headless
    maven
    nodejs_22
    python312
    terraform
    unstable.go
    unstable.rustup
    sqlite
    unstable.iterm2
    stack
    ghc
    elan
    unstable.inkscape
    unstable.gimp
    texliveFull
  ];

  home.stateVersion = "24.11";
}
