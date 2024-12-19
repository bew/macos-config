{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    terraform # unfree (!!)
  ];
  nixpkgs.config.allowUnfreePredicate = pkg: pkg.pname == "terraform";
}
