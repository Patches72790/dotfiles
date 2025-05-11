{
  description = "Home Manager configuration of patroclus";

  # To update, run:
  # nix flake update
  # home-manager switch --flake .
  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # for creating symlinks for terminal apps to run with spotlight
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , mac-app-util
    , nixpkgs-darwin
    , nix-darwin
    , ...
    } @ inputs:
    let
      system-fn = n: if n == "patroclus" then "x86_64-linux" else "aarch64-darwin";
      #commonArgs = { inherit system; config.allowUnfree = true; };
      #pkgs = import nixpkgs commonArgs;
      #unstable = import nixpkgs-unstable commonArgs;
    in
    {
      homeConfigurations."patroclus" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = (system-fn "patroclus");
          config.allowUnfree = true;
        };
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./manjaro ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit inputs;
          pkgs = import nixpkgs {
            system = (system-fn "patroclus");
            config.allowUnfree = true;
          };
          unstable = import nixpkgs-unstable {
            system = (system-fn "patroclus");
            config.allowUnfree = true;
          };
        };
      };

      darwinConfigurations."DOIT-X3PG99RC-X" = nix-darwin.lib.darwinSystem {
        pkgs = import nixpkgs-darwin {
          system = (system-fn "plharvey");
          config.allowUnfree = true;
        };

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

              extraSpecialArgs = {
                inherit inputs;
                pkgs = import nixpkgs-darwin {
                  system = (system-fn "plharvey");
                  config.allowUnfree = true;
                };
                unstable = import nixpkgs-unstable {
                  system = (system-fn "plharvey");
                  config.allowUnfree = true;
                };

              };
            };
            users.users.plharvey.home = "/Users/plharvey";
          }
        ];

        specialArgs = {
          inherit inputs;
          pkgs = import nixpkgs-darwin {
            system = (system-fn "plharvey");
            config.allowUnfree = true;
          };
          unstable = import nixpkgs-unstable {
            system = (system-fn "plharvey");
            config.allowUnfree = true;
          };

        };
      };
    };
}
