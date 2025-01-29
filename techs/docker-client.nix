{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    docker-client # client only, to get shell completions

    lazydocker # Nice TUI for docker (in Go)
    oxker # Another nice TUI for docker (in Rust)
  ];
}
