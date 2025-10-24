{ pkgs, lib, config, ... }:

let
  ty = lib.types;
  cfg = config.programs.hammerspoon;
  cfg_defaults = config.system.defaults."org.hammerspoon.Hammerspoon";
in {
  options = {
    programs.hammerspoon = {
      enable = lib.mkEnableOption "hammerspoon";
      package = lib.mkOption {
        type = ty.package;
        default = pkgs.callPackage ../pkgs/hammerspoon.nix {};
        description = "The package derivation";
      };
    };

    system.defaults."org.hammerspoon.Hammerspoon" = {
      # note: not documented but stable
      #   see: https://github.com/Hammerspoon/hammerspoon/issues/3103
      MJConfigFile = lib.mkOption {
        type = ty.nullOr ty.str;
        default = null;
        description = ''
          Path to the configuration file. (Default is `~/.hammerspoon/init.lua`)
        '';
      };

      MJKeepConsoleOnTopKey = lib.mkOption {
        type = ty.nullOr ty.bool;
        default = null;
        description = ''
          Keep the Console window on top of other windows when it is opened
        '';
      };

      MJShowDockIconKey = lib.mkOption {
        type = ty.nullOr ty.bool;
        default = null;
        description = ''
          Show the Hammerspoon app icon in the dock
        '';
      };

      MJShowMenuIconKey = lib.mkOption {
        type = ty.nullOr ty.bool;
        default = null;
        description = ''
          Show the Hammerspoon icon in the menubar

          Recommanded, otherwise it is hard to open Hammerspoon's preferences or the console window.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    system.defaults.CustomUserPreferences."org.hammerspoon.Hammerspoon" = cfg_defaults;
  };
}
