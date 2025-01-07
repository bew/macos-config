{pkgsChannels, ...}:

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
    stable.ripgrep
    stable.tealdeer # nice tldr impl
    stable.nix-tree
    bleedingedge.ast-grep
  ];

  imports = [
    ./techs/aws.nix
    ./techs/pythons.nix
    ./techs/terraform.nix
  ];
}
