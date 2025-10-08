{
  config,
  pkgs,
  ...
}: {
  home.file = {
    ".config/gsimplecal" = {
      text = ''
        show_week_numbers=1
        force_lang=en_GB.UTF8
      '';
    };
  };
  home.packages = with pkgs; let
    gsimplecal-desktop =
      pkgs.makeDesktopItem
      {
        name = "gsimplecal";
        desktopName = "gsimplecal";
        exec = "${pkgs.gsimplecal}/bin/gsimplecal";
        icon = "calendar";
        categories = ["System"];
        mimeTypes = ["application/octet-stream"];
      };
  in [gsimplecal-desktop gsimplecal];
}
