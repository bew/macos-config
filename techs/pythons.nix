{ pkgs, lib, pkgsChannels, mybuilders, ... }:

let
  pyVersion = (
    {
      pyDrv,
      poetryDrv,
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
        (mybuilders.linkBin "poetry${binNameSuffix}" (poetryDrv.override { python3 = pyDrv; }))
      ];
      passthru.usedBinNameSuffix = binNameSuffix;
      passthru.usedPythonDrv = pyDrv;
    }
  );

  pyDefault = pyVersionDrv: pkgs.buildEnv {
    name = "default-python";
    paths = [
      pyVersionDrv.usedPythonDrv # MAYBE: remove useless binaries?
      (mybuilders.linkBin "ipython" "${pyVersionDrv}/bin/ipython${pyVersionDrv.usedBinNameSuffix}")
      # I want Poetry v2+ 😬
      # (mybuilders.linkBin "poetry" "${pyVersionDrv}/bin/poetry${pyVersionDrv.usedBinNameSuffix}")
    ];
  };
in
let

  inherit (pkgsChannels) stable bleedingedge;

  pyVersionDrvs = {
    "3.12" = pyVersion {
      pyDrv = stable.python312;
      poetryDrv = stable.poetry;
      binNameSuffix = "3.12";
    };
    "3.13" = pyVersion {
      pyDrv = bleedingedge.python313;
      poetryDrv = bleedingedge.poetry;
      binNameSuffix = "3.13";
    };
  };

in {
  environment.systemPackages = [
    pyVersionDrvs."3.12"
    pyVersionDrvs."3.13"
    (pyDefault pyVersionDrvs."3.12")
    bleedingedge.poetry # I want last version poetry (v2+)
  ];
}
