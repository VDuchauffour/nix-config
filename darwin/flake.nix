{
  description = "My nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    mac-app-util,
  }: let
    vars = {
      user = "k";
      computerName = "k-MacBook-Pro";
      terminal = "alacritty";
      editor = "nvim";
      defaultBrowser = "librewolf";
    };
    configuration = {
      lib,
      pkgs,
      config,
      ...
    }: {
      nix.settings.experimental-features = "nix-command flakes";
      system.configurationRevision = self.rev or self.dirtyRev or null;
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

      system.activationScripts.defaultBrowser.text = ''
        defaultbrowser "${vars.defaultBrowser}"
      '';

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = (import ../common/packages {inherit pkgs;}).cli ++ [pkgs.defaultbrowser];
      homebrew = import ./homebrew.nix;

      fonts = {
        packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
      };

      environment.variables = rec {
        EDITOR = "${vars.editor}";
        VISUAL = "${vars.editor}";

        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_STATE_HOME = "$HOME/.local/state";

        XDG_BIN_HOME = "$HOME/.local/bin";
        #PATH = [
        #  "${XDG_BIN_HOME}"
        #];
      };
    };
  in {
    darwinConfigurations.${vars.computerName} = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        configuration
        mac-app-util.darwinModules.default
        home-manager.darwinModules.home-manager
        (
          {
            lib,
            pkgs,
            config,
            inputs,
            ...
          }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.k = import ./home.nix {inherit config lib vars pkgs;};
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
          }
        )
      ];
    };
    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.${vars.computerName}.pkgs;
  };
}
