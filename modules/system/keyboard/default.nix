{lib, ...}: {
  # For X11/Wayland
  services.xserver.xkb.extraLayouts.custom = {
    description = "Custom layout with ² as Escape";
    languages = ["eng"];
    symbolsFile = builtins.toFile "custom-symbols" ''
      partial modifier_keys
      xkb_symbols "basic" {
        key <TLDE> { [ Escape ] };
      };
    '';
  };

  # For console (TTY)
  console.keyMap = lib.mkForce (builtins.toFile "custom-keymap.map" ''
    keymaps 0-127
    keycode 41 = Escape
  '');
}
