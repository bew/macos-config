{ pkgs, lib, pkgsChannels, mybuilders, ... }:

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

  inherit (pkgsChannels) stable bleedingedge;

  pyVersionDrvs = {
    "3.11" = pyVersion {
      pyDrv = stable.python311;
      binNameSuffix = "3.11";
    };
    "3.12" = pyVersion {
      pyDrv = stable.python312;
      binNameSuffix = "3.12";
    };
    "3.13" = pyVersion {
      pyDrv = bleedingedge.python313;
      binNameSuffix = "3.13";
    };
  };

in {
  environment.systemPackages = [
    pyVersionDrvs."3.11"
    pyVersionDrvs."3.12"
    pyVersionDrvs."3.13"
    (pyDefault pyVersionDrvs."3.12")
  ];
}
