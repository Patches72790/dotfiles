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

    nixgl.url = "github:nix-community/nixGL";

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # for creating symlinks for terminal apps to run with spotlight
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    { nixpkgs
    , nixpkgs-unstable
    , home-manager
    , mac-app-util
    , nixpkgs-darwin
    , nix-darwin
    , nixgl
    , ...
    } @ inputs:
    let
      system-fn = n: if n == "patroclus" then "x86_64-linux" else "aarch64-darwin";
      commonArgsFn = system-name: {
        system = system-fn system-name;
        config.allowUnfree = true;
        overlays = [ nixgl.overlay ];
      };
      pkgFn = name: pkg: import pkg (commonArgsFn name);
    in
    {
      homeConfigurations."patroclus" = home-manager.lib.homeManagerConfiguration {
        pkgs = (pkgFn "patroclus" nixpkgs);

        modules = [ ./manjaro ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          pkgs = (pkgFn "patroclus" nixpkgs);
          unstable = (pkgFn "patroclus" nixpkgs-unstable);
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
