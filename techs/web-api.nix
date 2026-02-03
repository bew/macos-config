{pkgs, pkgsChannels, ...}:

let
  inherit (pkgsChannels) bleedingedge;
in {
  environment.systemPackages = [
    # API client for interactive manual testing
    bleedingedge.bruno
    bleedingedge.bruno-cli
  ];
}
