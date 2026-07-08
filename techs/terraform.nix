{pkgs, mybuilders, ...}:

{
  environment.systemPackages = with pkgs; [
    terraform # unfree (!!)

    # MAYBE: find a better way to setup `tf` alias 👀 (need completions!)
    (mybuilders.linkBin "tf" terraform)
  ];
}
