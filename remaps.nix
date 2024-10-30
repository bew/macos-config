{
  # NOTE: these remaps are done for all devices, even USB-connected keyboards
  #   like ZSA making Ctrl act as Fn instead of Ctrl ><
  # => Instead remap these using Karabiner-elements only for built-in keyboard.
  # system.keyboard = {
  #   enableKeyMapping = true;
  #   # nonUS.remapTilde = true;
  #   remapCapsLockToEscape = true;
  #   swapLeftCtrlAndFn = true;
  # };

  # Setup various services
  # services.karabiner-elements.enable = true;
  # FIXME: currently broken, see: https://github.com/LnL7/nix-darwin/issues/1132

  # TODO: setup key remapping in Nix here, and generate ~/.config/karabiner folder
}
