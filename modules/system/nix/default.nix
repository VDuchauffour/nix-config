{
  config,
  vars,
  ...
}: {
  system.configurationRevision = config.rev or config.dirtyRev or null;
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = ["root" "${vars.userName}"];
      allowed-users = ["${vars.userName}"];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
    };
  };
}
