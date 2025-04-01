{ config, pkgs, unstable, ... }: {

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
    iterm2
    stack
    ghc
    elan
  ];

  home.stateVersion = "24.11";
}
