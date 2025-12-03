{ config, pkgs, unstable, ... }: {

  imports = [
    ../manjaro/zsh
  ];

  home.packages = with pkgs; [
    config.nix.package
    unstable.obsidian
    unstable.vscode
    unstable.neovim
    unstable.jetbrains.idea-ultimate
    unstable.opentofu
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
    unstable.texliveFull
    unstable.uv
    unstable.typst
    unstable.tinymist
    cairo
    pkg-config
  ];

  home.stateVersion = "24.11";
}
