{config, ...}: {
  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = config.rev or config.dirtyRev or null;
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };
  nix.optimise = {
    automatic = true;
  };
}
