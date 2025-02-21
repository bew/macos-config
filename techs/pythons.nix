{ pkgs, lib, pkgsChannels, ... }:

let
  inherit (pkgsChannels) stable bleedingedge;

  linkBin = binName: pathOrDrv: (
    let
      path = (
        if lib.isDerivation pathOrDrv
        then lib.getExe pathOrDrv
        else pathOrDrv
      );
    in pkgs.runCommandLocal "${binName}-single-bin" { meta.mainProgram = binName; } ''
      mkdir -p $out/bin
      ln -s ${lib.escapeShellArg path} $out/bin/${binName}
    ''
  );

  pkgsForPy = pyDrv: poetryDrv: binNameSuffix: [
    (linkBin "python${binNameSuffix}" pyDrv)
    (linkBin "poetry${binNameSuffix}" (poetryDrv.override { python3 = pyDrv; }))
  ];

  recentPythons = pkgs.buildEnv {
    name = "recent-pythons";
    paths = lib.flatten [
      (pkgsForPy stable.python312 stable.poetry "312")
      # wants to rebuild stuff... it's the default anyway, let's just avoid it here
      # (pkgsForPy bleedingedge.python313 bleedingedge.poetry "313")
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
