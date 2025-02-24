{pkgs, mybuilders, ...}:

{
  environment.systemPackages = with pkgs; [
    terraform # unfree (!!)

    # MAYBE: find a better way to setup `tf` alias 👀
    (mybuilders.linkBin "tf" terraform)
  ];
  # FIXME: how to specify unfree predicates for an arbitrary/all pkgsChannel??
  nixpkgs.config.allowUnfreePredicate = pkg: pkg.pname == "terraform";
}
