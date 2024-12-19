{pkgs, lib, ...}: {
  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    # Minimal usable CLI environment 😬
    neovim
    eza
    fd
    just
    bat
    git
    gitAndTools.delta
    ripgrep
    tealdeer # nice tldr impl
    nix-tree
  ];

  imports = [
    ./techs/aws.nix
    ./techs/pythons.nix
    ./techs/terraform.nix
  ];
}
