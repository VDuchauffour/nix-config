{
  boot.kernelModules = ["xpad"];
  # Optional: if you need force feedback/rumble
  boot.extraModprobeConfig = ''
    options xpad enable_ff=1
  '';
}
