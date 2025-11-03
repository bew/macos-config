{ pkgsChannels, ... }:

let
  inherit (pkgsChannels) stable bleedingedge;
in {
  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  environment.systemPackages = [
    # Minimal usable CLI environment 😬
    stable.neovim
    stable.eza
    stable.fd
    stable.just
    stable.bat
    stable.git
    stable.gitAndTools.delta
    bleedingedge.mergiraf
    stable.git-trim
    stable.lazygit
    stable.gh
    stable.ripgrep
    stable.tealdeer # nice tldr impl
    stable.yazi
    stable.htop
    stable.tokei
    bleedingedge.nushell

    stable.nix-tree
    stable.nix-output-monitor

    # Project-specific env managers

    # "The front-end to your dev env", https://mise.jdx.dev/
    # (can install project-specific tools, and replace just & direnv)
    bleedingedge.mise

    # "Fast, Declarative, Reproducible and Composable Developer Environments using Nix", https://devenv.sh/
    # (can install project-specific tools, setup services, ... and replace just)
    bleedingedge.devenv
  ];

  imports = [
    ./techs/ai.nix # let's try...
    ./techs/aws.nix
    ./techs/docker-client.nix
    ./techs/pythons.nix
    ./techs/terraform.nix
    ./techs/web-api.nix
  ];
}
