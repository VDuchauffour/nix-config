{
  lib,
  pkgs,
  ...
}: {
  # For X11/Wayland
  services.xserver = {
    xkb = {
      layout = lib.mkForce "fr-custom";
      options = "lv3:ralt_switch";
      extraLayouts.fr-custom = {
        description = "French AZERTY with ² as Escape";
        languages = ["fra"];
        symbolsFile = builtins.toFile "fr-custom-symbols" ''
          default partial alphanumeric_keys
          xkb_symbols "basic" {
            include "fr(latin9)"
            key <TLDE> { [ Escape, Escape ] };
          };
        '';
      };
    };
  };

  # For console (TTY)
  console.keyMap = lib.mkForce (pkgs.writeText "custom-keymap.map" ''
    keymaps 0-127
    keycode 41 = Escape
    include "${pkgs.kbd}/share/keymaps/i386/azerty/fr-latin9.map.gz"
  '');
}
