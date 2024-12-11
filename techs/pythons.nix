{ pkgs, lib, ... }:

let
  linkBin = binName: path: (
    pkgs.runCommandLocal "${binName}-single-bin" { meta.mainProgram = binName; } ''
      mkdir -p $out/bin
      ln -s ${lib.escapeShellArg path} $out/bin/
    ''
  );

  recentPythons = pkgs.buildEnv {
    name = "recent-pythons";
    paths = [
      (linkBin "python311" (lib.getExe pkgs.python311))
      (linkBin "python312" (lib.getExe pkgs.python312))
      (linkBin "python313" (lib.getExe pkgs.python313))
    ];
  };

  defaultPython = pkgs.python313;

in {
  environment.systemPackages = [
    recentPythons
    defaultPython
  ];
}
