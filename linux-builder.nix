{ pkgsets, ... }:

let
  inherit (pkgsets) bleedingedge;
in

# https://nixcademy.com/posts/rosetta-linux-builder-macos/
# NOTE: this adds ~1G to my nix-darwin closure
{
  nix.linux-builder = {
    enable = true;

    package = bleedingedge.darwin.linux-builder-vz;
    systems = [ "aarch64-linux" "x86_64-linux" ];

    # Performance/tuning settings
    # (from the nixcademy post 🤔, with slight tweaks)
    ephemeral = true; # Delete the builder’s disk image on every restart
    maxJobs = 4;
    config = {
      virtualisation.darwin-builder = {
        # ⚠️ Changes to these values do NOT take effect on nix-darwin activation
        # - If `ephemeral=false`, delete the VM disk first: `sudo rm /var/lib/linux-builder/nixos.qcow2`
        # - Restart the VM: `sudo launchctl kickstart -k system/org.nixos.linux-builder`
        diskSize = 30 * 1024; # in GB
        memorySize = 4 * 1024; # in GB
      };
      virtualisation.cores = 4;
    };
  };

  # Trust everyone in the macOS admin group
  nix.settings.trusted-users = [ "@admin" ];
  # NOTE: This is needed because Nix's model for remote builders requires the calling user to be
  # able to import build results directly into the store without cryptographic verification,
  # and only trusted users are allowed to do that.
}
