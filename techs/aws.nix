{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    awscli2
    awslogs # Helper to get logs (awscli can only get from one log stream)
  ];
}
