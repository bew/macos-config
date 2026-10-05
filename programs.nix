{ pkgsets, ... }:

let
  inherit (pkgsets) stable bleedingedge;
in {
  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  environment.systemPackages = [
    # Basic usable CLI environment 😬
    stable.neovim
    stable.eza
    stable.fd
    stable.just
    stable.bat
    stable.tree
    stable.sd

    stable.unixtools.watch # the `watch` cmd (missing on macOS..)

    stable.tealdeer # nice tldr impl
    stable.yazi
    stable.htop

    stable.ncdu

    # bleedingedge.opencode # AI client on-demand
    # (→ I add it in my home setup!)
  ];

  imports = [
    ./techs/atlassian.nix
    # ./techs/aws.nix
    ./techs/benchmarks.nix
    ./techs/docker-client.nix
    ./techs/javascript-frontend.nix
    ./techs/local_postgresql.nix
    # ./techs/pythons.nix
    # ./techs/terraform.nix
  ];
}
