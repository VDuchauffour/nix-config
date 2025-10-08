{
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };
  nix.optimise = {
    automatic = true;
  };
}
