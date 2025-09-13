{
  config,
  lib,
  pkgs,
  vars,
  ...
}: let
  my-kubernetes-helm = with pkgs;
    wrapHelm kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
        helm-s3
        helm-git
      ];
    };

  my-helmfile = pkgs.helmfile-wrapped.override {
    inherit (my-kubernetes-helm) pluginsDir;
  };
in {
  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = config.rev or config.dirtyRev or null;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nix.optimise = {
    automatic = true;
  };

  users.users.k = {
    home = "/Users/${vars.userName}";
    name = "${vars.userName}";
  };
  system.primaryUser = vars.userName;

  system.defaults = (import ./system.nix {inherit vars;}).defaults;
  security.pam.services.sudo_local.touchIdAuth = true;

  system.activationScripts.activateSettings.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    launchctl stop com.apple.Dock.agent
    launchctl start com.apple.Dock.agent
  '';

  # TODO fix this
  system.activationScripts.defaultBrowser.text = ''
    defaultbrowser "librewolf"
  '';

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; (import ../../../nix/packages {inherit pkgs;}
    ++ [
      defaultbrowser
      ext4fuse
      texliveFull
      my-kubernetes-helm
      my-helmfile
    ]);
  homebrew = import ./homebrew.nix;

  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
