# MacOS config with Nix :sparkles:

Using nix-darwin for most system config


---

Configs to apply manually:
- Keyboard layout: `French - PC`
  (need to remove the default `French = AZERTY` to take effect and be the default)

Programs to install manually:

- Karabiner-elements (https://karabiner-elements.pqrs.org/), because the service module is currently [broken :/](https://github.com/LnL7/nix-darwin/issues/1132).
  (config is in `~/.config/karabiner`, TODO: Nixify!)
