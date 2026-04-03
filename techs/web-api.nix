{pkgs, pkgsets, ...}:

let
  inherit (pkgsets) bleedingedge;
in {
  environment.systemPackages = [
    # API client for interactive manual testing
    bleedingedge.bruno
    bleedingedge.bruno-cli
  ];
}
