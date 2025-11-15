{
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true; # headless
    desktopManager.xterm.enable = false;
  };

  environment.etc."X11/xorg.conf.d/10-virtual.conf".text = ''
    Section "Monitor"
        Identifier "Monitor0"
        HorizSync 28.0-55.0
        VertRefresh 43.0-72.0
        Modeline "1920x1080" 172.8 1920 2008 2052 2200 1080 1084 1088 1125 +HSync +VSync
    EndSection

    Section "Device"
        Identifier "Device0"
        Driver "intel"   # or "amdgpu" / "nvidia"
    EndSection

    Section "Screen"
        Identifier "Screen0"
        Device "Device0"
        Monitor "Monitor0"
        SubSection "Display"
            Modes "1920x1080"
        EndSubSection
    EndSection
  '';
}
