{pkgs, ...}: {
  home.packages = [
    (pkgs.symlinkJoin {
      name = "slack-with-pipewire";
      paths = [pkgs.slack];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/slack --add-flags "--enable-features=WebRTCPipeWireCapturer"
      '';
    })
  ];
  xdg.mimeApps.defaultApplications."x-scheme-handler/slack" = "slack.desktop";
}
