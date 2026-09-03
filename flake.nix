{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgsBleedingEdge.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    #home-manager.url = "github:nix-community/home-manager";

    # dots.url = "github:bew/dotfiles";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgsBleedingEdge, ... }:
  let
    configuration = { pkgs, lib, config, pkgsets, ... }: let system = "aarch64-darwin"; in {
      imports = [
        #inputs.home-manager.darwinModules.default
        ./system.nix
        ./remaps.nix
        ./desktop.nix
        ./programs.nix
        ./linux-builder.nix
      ];

      _module.args.pkgsets = {
        stable = nixpkgs.legacyPackages.${system};
        bleedingedge = nixpkgsBleedingEdge.legacyPackages.${system};
      };

      _module.args.mybuilders = import ./lib/mybuilders.nix { inherit pkgs lib; };

      nixpkgs.config.allowUnfree = true;

      nix.package = pkgsets.bleedingedge.nixVersions.latest;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      # Avoid issue "download buffer is full; consider increasing the 'download-buffer-size' setting"
      # REF: https://github.com/NixOS/nix/issues/11728#issuecomment-2725297584
      # .. might be fixed in next (@2025-12) Nix release
      nix.settings.download-buffer-size = 512 * 1000 * 1000; # 512M

      # Nix global/system flake registr
      nixpkgs.flake.setFlakeRegistry = false; # Don't set 'nixpkgs' in system flake registry
      nixpkgs.flake.setNixPath = false; # necessary for setFlakeRegistry=false
      nix.settings.flake-registry = ""; # No global registry
      nix.registry = {
        pkgs.flake = nixpkgs;
        unstable.to = {
          type = "github";
          owner = "nixos";
          repo = "nixpkgs";
          ref = "nixpkgs-unstable";
        };
        dots.to = {
          type = "path";
          path = "${config.system.primaryUserHome}/.dot";
        };
      };

      # Used for all options that applies to the primary user (many in `system.defaults.*`)
      system.primaryUser = "benoitlesellierdechezelles";
      environment.variables.XDG_CONFIG_HOME = "${config.system.primaryUserHome}/.config";
      nix.settings.trusted-users = [config.system.primaryUser];

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      environment.systemPackages = [
        # Used to show closure diff on rebuild
        pkgsets.bleedingedge.dix # a wip (@2026-08) Rust-rewrite of nvd

        # 🤯 Tool to access ~all version of ~all packages from any rev of nixpkgs 🤯
        # <https://nixmultiverse.com/docs/cli>
      ];

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
