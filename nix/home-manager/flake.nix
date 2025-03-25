{
  description = "Home Manager configuration of patroclus";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      commonArgs = { inherit system; config.allowUnfree = true; };
      pkgs = import nixpkgs commonArgs;
      unstable = import nixpkgs-unstable commonArgs;
    in
    {
      homeConfigurations."patroclus" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit pkgs unstable inputs; };
      };
    };
}
