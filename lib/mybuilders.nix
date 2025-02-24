{ pkgs, lib }:

{
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
}
