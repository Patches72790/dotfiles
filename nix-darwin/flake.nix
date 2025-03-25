{
  description = "Plharvey MacOS nix-darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # for creating symlinks for terminal apps to run with spotlight
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    inputs@{ self
    , nix-darwin
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , mac-app-util
    }:
    let
      system = "aarch64-darwin";
      commonArgs = { inherit system; config.allowUnfree = true; };
      pkgs = import nixpkgs commonArgs;
      unstable = import nixpkgs-unstable commonArgs;
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#DOIT-X3PG99RC-X
      darwinConfigurations."DOIT-X3PG99RC-X" = nix-darwin.lib.darwinSystem {
        modules = [
          ./darwin/configuration.nix

          mac-app-util.darwinModules.default

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              # include the home-manager module
              users.plharvey = import ./darwin/home.nix;

              # for creating symlinks for terminal apps to run with spotlight
              sharedModules = [
                mac-app-util.homeManagerModules.default
              ];

              extraSpecialArgs = { inherit pkgs unstable inputs; };
            };
            users.users.plharvey.home = "/Users/plharvey";
          }
        ];

        specialArgs = { inherit pkgs unstable inputs; };
      };
    };
}
