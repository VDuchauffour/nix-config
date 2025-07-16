{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    let
      homebrewPackages = import ./homebrew.nix;
      packages = import ../common/packages { inherit pkgs; };
      vars = {
        user = "k";
        computerName = "k-MacBook-Pro";
        terminal = "alacritty";
        editor = "nvim";
      };
      configuration = { pkgs, ... }: {
        nix.settings.experimental-features = "nix-command flakes";
        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 6;
        nixpkgs.hostPlatform = "aarch64-darwin";

        users.users.k = {
          home = "/Users/${vars.user}";
          name = "${vars.user}";
        };
        system.primaryUser = vars.user;

        system.defaults = (import ./system.nix { inherit vars; }).defaults;
        security.pam.services.sudo_local.touchIdAuth = true;

        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = packages.cli;

        homebrew = {
          enable = true;
          onActivation = {
            autoUpdate = true;
            upgrade = false;
            cleanup = "uninstall";
          };
          brewPrefix = "/opt/homebrew/bin";
          caskArgs = {
            no_quarantine = true;
          };
          casks = homebrewPackages.casks;
          brews = homebrewPackages.brews;
          taps = homebrewPackages.taps;
          masApps = homebrewPackages.masApps;
        };
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations.${vars.computerName} = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.k = import ./home.nix { inherit vars; };
          }
        ];
      };
      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations.${vars.computerName}.pkgs;
    };
}
