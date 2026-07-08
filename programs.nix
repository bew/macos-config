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

    stable.unixtools.watch # the `watch` cmd (missing on macOS..)

    stable.ripgrep
    stable.tealdeer # nice tldr impl
    stable.yazi
    stable.htop
    stable.tokei
    stable.bacon # background code checker
    bleedingedge.nushell

    stable.bats # Bash Automated Testing System (useful when making scripts!)

    # Git stuff
    stable.git
    stable.delta
    stable.mergiraf
    stable.git-trim
    stable.lazygit
    stable.gh

    stable.ncdu
    bleedingedge.opencode # AI client on-demand

    stable.nix-tree
    stable.nix-output-monitor
  ];

  imports = [
    ./techs/atlassian.nix
    ./techs/aws.nix
    ./techs/docker-client.nix
    ./techs/javascript-frontend.nix
    ./techs/local_postgresql.nix
    ./techs/pythons.nix
    ./techs/terraform.nix
    ./techs/web-api.nix
  ];
}
