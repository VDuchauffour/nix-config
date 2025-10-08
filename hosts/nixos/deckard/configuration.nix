{
  config,
  pkgs,
  vars,
  ...
}: {
  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = config.rev or config.dirtyRev or null;
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  users.users."${vars.userName}" = {
    home = "/home/${vars.userName}";
    name = "${vars.userName}";
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "audio" "video" "users" "input" "networkmanager"];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  # To search by name, run: nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
    (import ../../../packages {inherit pkgs;})
    ++ (import ../../../packages/nixos.nix {inherit pkgs;});

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  imports = [
    ./hardware.nix
  ];
}
