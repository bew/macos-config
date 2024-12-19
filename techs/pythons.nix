{ pkgs, lib, ... }:

let
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

  pkgsForPy = pyDrv: binNameSuffix: [
    (linkBin "python${binNameSuffix}" pyDrv)
    (linkBin "poetry${binNameSuffix}" (pkgs.poetry.override { python3 = pyDrv; }))
  ];

  recentPythons = pkgs.buildEnv {
    name = "recent-pythons";
    paths = lib.flatten [
      (pkgsForPy pkgs.python311 "311")
      (pkgsForPy pkgs.python312 "312")
      # mypy not yet available for py313, needed to install poetry
      # (pkgsForPy pkgs.python313 "313")
    ];
  };

  defaultPython = let
    defaultPyDrv = pkgs.python312;
  in pkgs.buildEnv {
    name = "default-python";
    paths = [
      (linkBin "python3" defaultPyDrv)
    ] ++ (pkgsForPy defaultPyDrv "");
  };

in {
  environment.systemPackages = [
    recentPythons
    defaultPython
  ];
}
