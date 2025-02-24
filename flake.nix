{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgsBleedingEdge.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    #home-manager.url = "github:nix-community/home-manager";

    # dots.url = "github:bew/dotfiles";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgsBleedingEdge, ... }:
  let
    configuration = { pkgs, lib, ... }: let system = "aarch64-darwin"; in {
      imports = [
        #inputs.home-manager.darwinModules.default
        ./system.nix
        ./remaps.nix
        ./desktop.nix
        ./programs.nix
      ];

      _module.args.pkgsChannels = {
        stable = nixpkgs.legacyPackages.${system};
        bleedingedge = nixpkgsBleedingEdge.legacyPackages.${system};
      };

      _module.args.mybuilders = import ./lib/mybuilders.nix { inherit pkgs lib; };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = system;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#FRPARALT0054
    darwinConfigurations."FRPARALT0054" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
