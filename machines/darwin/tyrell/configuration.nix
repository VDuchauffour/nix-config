{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = config.rev or config.dirtyRev or null;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  users.users.k = {
    home = "/Users/${vars.user}";
    name = "${vars.user}";
  };
  system.primaryUser = vars.user;

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
    defaultbrowser "${vars.defaultBrowser}"
  '';

  # TODO doesnt works either
  system.activationScripts.setExt4Fuse.text = ''
    echo "Setting up ext4fuse"
    if [ ! -f ~/.local/bin/ext4fuse ]; then
      git clone https://github.com/gerard/ext4fuse.git && cd "$(basename "$_" .git)"
      make
    fi
  '';

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = (import ../../../common/packages {inherit pkgs;}).cli ++ [pkgs.defaultbrowser];
  homebrew = import ./homebrew.nix;

  fonts = {
    packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };
}
