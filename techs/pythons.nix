{ pkgs, lib, pkgsChannels, mybuilders, ... }:

let
  inherit (pkgsChannels) stable bleedingedge;

  pkgsForPy = pyDrv: poetryDrv: binNameSuffix: [
    (mybuilders.linkBin "python${binNameSuffix}" pyDrv)
    (mybuilders.linkBin "poetry${binNameSuffix}" (poetryDrv.override { python3 = pyDrv; }))
  ];

  recentPythons = pkgs.buildEnv {
    name = "recent-pythons";
    paths = lib.flatten [
      (pkgsForPy stable.python312 stable.poetry "3.12")
      # wants to rebuild stuff... it's the default anyway, let's just avoid it here
      # (pkgsForPy bleedingedge.python313 bleedingedge.poetry "3.13")
    ];
  };

  defaultPython = pkgs.buildEnv {
    name = "default-python";
    paths = [
      bleedingedge.python313
      bleedingedge.poetry
    ];
  };

in {
  environment.systemPackages = [
    recentPythons
    defaultPython
  ];
}
