{ config, lib, pkgs, unstable, ... }:
{
  programs.neovim = {
    enable = true;
    package = unstable.neovim-unwrapped;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;

    plugins = with unstable.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      plenary-nvim
      gruvbox-material
      blink-cmp
      telescope-nvim
      mini-nvim
      oil-nvim
    ];
  };
}
