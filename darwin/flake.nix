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

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = (import ../common/packages {inherit pkgs;}).cli;

      fonts = {
        packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
      };

      homebrew = import ./homebrew.nix;
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
            pkgs,
            config,
            inputs,
            ...
          }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.k = import ./home.nix {inherit vars;};
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
