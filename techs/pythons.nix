{ pkgs, lib, pkgsets, mybuilders, mv, ... }:

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

  getLatestForMinor = pyVersions: targetVersion:
    let
      matchingPyVersions = builtins.filter
        (v: lib.versions.majorMinor v == targetVersion)
        pyVersions;
    in lib.last matchingPyVersions;

in
let

  inherit (pkgsets) stable bleedingedge;

  multiverse_pyVersionDrvs = let
    # Use nixpkgs-multiverse 🚀
    pyDrvFor = targetVersion: let
      latestVersionForTarget = getLatestForMinor (mv.versionsOf "python3") targetVersion;
    in mv.versions.python3.${latestVersionForTarget};
    # WARNING: Cannot use `mv.fast.versions` (no fast index for aarch64-darwin ><)
    # ISSUE: https://github.com/fzakaria/nixpkgs-multiverse/issues/15
  in {
    "3.12" = pyVersion {
      pyDrv = pyDrvFor "3.12";
      binNameSuffix = "3.12";
    };
    "3.14" = pyVersion {
      pyDrv = pyDrvFor "3.14";
      binNameSuffix = "3.14";
    };
  };

  manual_pyVersionDrvs = {
    "3.12" = pyVersion {
      pyDrv = stable.python312;
      binNameSuffix = "3.12";
    };
    "3.14" = pyVersion {
      pyDrv = bleedingedge.python314;
      binNameSuffix = "3.14";
    };
  };

  # Cannot use `mv.fast.versions` (no fast index for aarch64-darwin ><)
  # WARNING: Because of I cannot use `mv.fast.versions` (see above), using multiverse for getting
  # 2 python versions add ~3s to the rebuild of my macos-config.. 😬😬😬
  # pyVersionDrvs = multiverse_pyVersionDrvs;
  pyVersionDrvs = manual_pyVersionDrvs;

in {
  environment.systemPackages = [
    pyVersionDrvs."3.12"
    pyVersionDrvs."3.14"
    (pyDefault pyVersionDrvs."3.12")
  ];
}
