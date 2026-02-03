{pkgs, mybuilders, ...}:

{
  environment.systemPackages = [
    (mybuilders.linkBin "npm" "${pkgs.nodejs}/bin/npm")
    (mybuilders.linkBin "node" "${pkgs.nodejs}/bin/node")
  ];
}
