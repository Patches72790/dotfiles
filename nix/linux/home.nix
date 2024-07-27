{ config, pkgs, ... }:
{

  home.username = "patroclus";
  home.homeDirectory = "/home/patroclus";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
