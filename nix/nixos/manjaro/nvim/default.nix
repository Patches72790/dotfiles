{ config, lib, pkgs, unstable, ... }:
{
  programs.neovim = {
    enable = true;
    package = unstable.neovim;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
  };
}
