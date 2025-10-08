{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

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

  homebrew = import ./homebrew.nix;
}
