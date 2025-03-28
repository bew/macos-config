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
    stable.git-trim
    stable.lazygit
    stable.gh
    stable.ripgrep
    stable.tealdeer # nice tldr impl
    stable.nix-tree
    stable.yazi
    stable.htop
  ];

  imports = [
    ./techs/ai.nix # let's try...
    ./techs/aws.nix
    ./techs/docker-client.nix
    ./techs/pythons.nix
    ./techs/terraform.nix
  ];
}
