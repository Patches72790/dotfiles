{ config, pkgs, lib, unstable, ... }: {
  # Wtf terraform?
  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    unstable.neovim
    jdk21_headless
    maven
    deno
    nodejs_20
    python312
    unstable.alacritty
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
