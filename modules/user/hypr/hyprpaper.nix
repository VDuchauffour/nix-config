{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      splash_offset = 2.0;

      preload = ["$HOME/.nix-config/assets/wallpapers/ocean_sky.jpg"];

      wallpaper = [
        ",$HOME/.nix-config/assets/wallpapers/ocean_sky.jpg"
      ];
    };
  };
}
