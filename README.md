# MacOS config with Nix :sparkles:

Using nix-darwin for most system config


---

### Configs to apply manually

- In OS configs:

  * 👉 Keyboard layout: `French - PC`
  (need to remove the default `French = AZERTY` to take effect and be the default)

- For `MiddleDrag` (https://middledrag.app/ | https://github.com/NullPointerDepressiveDisorder/MiddleDrag):
  Config happens in the menu of the system tray icon.

  * 👉 Need to disable `Drag` (pastes content in Wezterm on every desktop switch via touchpad' 3-fingers `Drag` ><)
    (At least 3-fingers `Tap` works well!)
  * 👉 Enable `Launch at login`

  > [!WARNING]
  > Until https://github.com/NullPointerDepressiveDisorder/MiddleDrag/pull/131 is released,
  > MiddleDrag can craft on wake-from-sleep 😬
  > (and we can't build from source with patch because it uses private touchpad libs)

### Programs to install manually

- Karabiner-elements (https://karabiner-elements.pqrs.org/), because the service module is currently [broken :/](https://github.com/LnL7/nix-darwin/issues/1132).
  (config is in `~/.config/karabiner`, TODO: Nixify!)
