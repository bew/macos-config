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

    stable.nix-tree
    stable.nix-output-monitor
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
