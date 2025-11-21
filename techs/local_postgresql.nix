{ pkgs, config, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    settings.listen_addresses = "localhost";

    # Not actually impl on the module @2025-11..
    # ensureDatabases = [ "myprojects" ];
  };

  # ------------------------------------------------------------------------

  # /!\ Postgres has trouble running with the current module @2025-11 /!\
  # SEE: https://github.com/nix-darwin/nix-darwin/issues/339

  # note: We add to the existing `preActivation` fragment, that runs before everything
  system.activationScripts.preActivation = {
    enable = true;
    # (note: the DB runs as my user! `staff` is the default non-admin group)
    text = let dataDir = config.services.postgresql.dataDir; in ''
      if [ ! -d "${dataDir}" ]; then
        echo "creating PostgreSQL data directory..."
        sudo mkdir -m 750 -p "${dataDir}"
        chown -R ${config.system.primaryUser}:staff "${dataDir}"
      fi
    '';
  };

  services.postgresql.initdbArgs = [
    # We should really change the (internal) `superUser` option instead 🤔
    "-U ${config.system.primaryUser}"
  ];

  launchd.user.agents.postgresql.serviceConfig = {
    StandardErrorPath = "/tmp/postgres.error.log";
    StandardOutPath = "/tmp/postgres.log";
  };
}
