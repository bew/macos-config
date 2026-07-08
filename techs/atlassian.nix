{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    acli # official Atlassian CLI (only supports Jira @2026-07) - unfree (!!)
  ];
}
