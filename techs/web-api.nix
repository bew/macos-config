{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    # API client for interactive manual testing
    bruno
    bruno-cli
  ];
}
