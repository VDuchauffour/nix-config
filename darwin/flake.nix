{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { self
    , nix-darwin
    , nixpkgs
    , home-manager
    ,
    }:
    let
      homebrewPackages = import ./homebrew.nix;
      vars = {
        user = "k";
        computerName = "k-MacBook-Pro";
        terminal = "alacritty";
        editor = "nvim";
      };
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = [ ];

        nix.settings.experimental-features = [ "nix-command" "flakes" ];
        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 4;
        system.defaults = (import ./system.nix { inherit vars; }).defaults;
        system.primaryUser = vars.user;

        nixpkgs.hostPlatform = "aarch64-darwin";

        users.users.k = {
          home = "/Users/${vars.user}";
          name = "${vars.user}";
        };
        home-manager.backupFileExtension = "backup";

        security.pam.services.sudo_local.touchIdAuth = true;

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

        programs = {
          # zsh = import ../common/home/zsh.nix;
          # direnv = import ../common/home/direnv.nix;
        };
      };
    in
    {
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
