{
  services.g810-led = {
    enable = true;
    profile = builtins.readFile ./profile;
  };
}
