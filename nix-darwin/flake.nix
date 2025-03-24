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
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      system = "aarch64-darwin";
      unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#DOIT-X3PG99RC-X
      darwinConfigurations."DOIT-X3PG99RC-X" = nix-darwin.lib.darwinSystem {
        modules = [
          ./darwin/configuration.nix

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              # include the home-manager module
              users.plharvey = import ./darwin/home.nix;
            };
            users.users.plharvey.home = "/Users/plharvey";
          }

          { home-manager.extraSpecialArgs = { inherit inputs; unstable = unstable; }; }
        ];

        specialArgs = { inherit inputs; unstable = nixpkgs-unstable; };
      };
    };
}
