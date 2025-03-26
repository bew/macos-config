{ pkgsChannels, ... }:

let
  inherit (pkgsChannels) stable bleedingedge;
in {
  environment.systemPackages = [
    # NOTE: Example usage with a Replicate model:
    # ```
    # export REPLICATE_API_KEY=...
    # cd $repo
    # aider --no-show-model-warnings --model replicate/anthropic/claude-3.7-sonnet
    # ```
    bleedingedge.aider-chat
  ];
}
