{ config, pkgs, unstable, ... }:
{
  imports = [
    ./home.nix
    ./configuration.nix
  ];
}
