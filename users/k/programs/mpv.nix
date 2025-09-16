{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      "osc" = true;
      "geometry" = "50%:50%";
      "autofit-larger" = "50%x50%";
      "player-operation-mode" = "pseudo-gui";
      "slang" = "en";
      "sub-font-size" = 40;
      "save-position-on-quit" = true;
      "alang" = "en,fr";
    };
    scripts = [
      pkgs.mpvScripts.autoload
      pkgs.mpvScripts.eisa01.simplehistory
    ];
  };
}
