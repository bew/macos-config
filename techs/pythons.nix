{ pkgs, lib, pkgsets, mybuilders, ... }:

let
  pyVersion = (
    {
      pyDrv,
      binNameSuffix,
    }:
    pkgs.buildEnv {
      name = "python-tools-bins-${binNameSuffix}";
      paths = [
        (
          let
            ipyEnv = pyDrv.withPackages (pypkgs: [ pypkgs.ipython pypkgs.rich ]);
          in mybuilders.linkBin "ipython${binNameSuffix}" "${ipyEnv}/bin/ipython"
        )
        (mybuilders.linkBin "python${binNameSuffix}" pyDrv)
      ];
      passthru.usedBinNameSuffix = binNameSuffix;
      passthru.usedPythonDrv = pyDrv;
    }
  );

  pyDefault = pyVersionDrv: pkgs.buildEnv {
    name = "default-python";
    paths = [
      pyVersionDrv.usedPythonDrv # MAYBE: remove useless binaries? (2to3, idle, pydoc, *-config, ..)
      (mybuilders.linkBin "ipython" "${pyVersionDrv}/bin/ipython${pyVersionDrv.usedBinNameSuffix}")
    ];
  };

in
let

  inherit (pkgsets) stable bleedingedge;

  # NOTE: We _cannot_ use nixpkgs-multiverse here to get the python versions,
  #   because we install both python & ipython (from `python.withPackages (...)`),
  #   nixpkgs-multiverse does NOT expose `passthru` Nix hunks, and we need that to get the correct
  #   ipython & its dependencies..
  pyVersionDrvs = {
    "3.12" = pyVersion {
      pyDrv = stable.python312;
      binNameSuffix = "3.12";
    };
    "3.14" = pyVersion {
      pyDrv = bleedingedge.python314;
      binNameSuffix = "3.14";
    };
  };

in {
  environment.systemPackages = [
    pyVersionDrvs."3.12"
    pyVersionDrvs."3.14"
    (pyDefault pyVersionDrvs."3.12")
  ];
}
