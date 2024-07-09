## Nix Configuraton

### nix-darwin

The `darwin-configuration.nix` represents the nix config file for use with MacOS related unix distributions.

Setup involves

1) installing nix via the regular pathways

2) installing nix-darwin and home-manager channels via `nix-channel`

3) linking the configuration file to `~/.nixpkgs/darwin-configuration.nix`.
