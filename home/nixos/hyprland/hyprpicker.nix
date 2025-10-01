{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    hyprpicker-desktop =
      pkgs.makeDesktopItem
      {
        name = "hyprpicker";
        desktopName = "hyprpicker";
        exec = "${pkgs.hyprpicker}/bin/hyprpicker";
        icon = "oasis-drawing";
        categories = ["System"];
        mimeTypes = ["application/octet-stream"];
      };
  in [hyprpicker-desktop];
}
