{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    terraform # unfree (!!)
  ];
  # FIXME: how to specify unfree predicates for an arbitrary/all pkgsChannel??
  nixpkgs.config.allowUnfreePredicate = pkg: pkg.pname == "terraform";
}
