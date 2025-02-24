{pkgs, mybuilders, ...}:

{
  environment.systemPackages = with pkgs; [
    docker-client # client only, to get shell completions

    lazydocker # Nice TUI for docker (in Go)
    oxker # Another nice TUI for docker (in Rust)

    # MAYBE: find a better way to setup `dk` alias 👀
    (mybuilders.linkBin "dk" "${docker-client}/bin/docker")
  ];
}
