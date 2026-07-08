{pkgs, mybuilders, ...}:

{
  environment.systemPackages = with pkgs; [
    docker-client # client only, to get shell completions

    lazydocker # Nice TUI for docker (in Go)
    (oxker.overrideAttrs { # Another nice TUI for docker (in Rust)
      # tests are kinda broken...
      # see: https://github.com/mrjackwills/oxker/issues/73
      doCheck = false;
    })

    # MAYBE: find a better way to setup `dk` alias 👀
    (mybuilders.linkBin "dk" "${docker-client}/bin/docker")
  ];
}
