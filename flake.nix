{
  description = "My NixOS and nix-darwin system configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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
    nixpkgs,
    nixos-unstable,
    nix-darwin,
    home-manager,
    mac-app-util,
  }: let
    vars = {
          user = "k";
          terminal = "alacritty";
          editor = "nvim";
          defaultBrowser = "librewolf";
        };

    machines = {
      deckard = {
        system = "x86_64-linux";
        hostname = "deckard";
      };

      tyrell = {
        system = "aarch64-darwin";
        hostname = "k-MacBook-Pro";
      };
    };

    # mkNixOSConfig = machineName: machineConfig: let
    #   pkgs = nixos-unstable.legacyPackages.${machineConfig.system};
    #   packages = import ./common/packages {inherit pkgs;};
    # in
    #   nixos-unstable.lib.nixosSystem {
    #     system = machineConfig.system;
    #     modules = [
    #       {
    #         nix.settings.experimental-features = "nix-command flakes";
    #         system.configurationRevision = self.rev or self.dirtyRev or null;
    #         system.stateVersion = "25.05";
    #         nixpkgs.hostPlatform = machineConfig.system;
    #         nixpkgs.config.allowUnfree = true;

    #         users.users.${vars.user} = {
    #           home = "/home/${vars.user}";
    #           name = "${vars.user}";
    #           isNormalUser = true;
    #           extraGroups = ["wheel" "docker"];
    #         };

    #         environment.systemPackages =
    #           packages.cli
    #           ++ packages.gui
    #           ++ [
    #             pkgs.playerctl
    #             pkgs.brightnessctl
    #             pkgs.pavucontrol
    #           ];

    #         fonts = {
    #           packages = builtins.filter nixos-unstable.lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
    #         };

    #         environment.variables = rec {
    #           EDITOR = "${vars.editor}";
    #           VISUAL = "${vars.editor}";
    #         };
    #       }
    #       home-manager.nixosModules.home-manager
    #       {
    #         home-manager.useGlobalPkgs = true;
    #         home-manager.useUserPackages = true;
    #         home-manager.users.${vars.user} = {
    #           config,
    #           lib,
    #           pkgs,
    #           ...
    #         }:
    #           import ./machines/nixos/${machineName}/home.nix {inherit config lib pkgs vars;};
    #         home-manager.backupFileExtension = "backup";
    #       }
    #       (import ./machines/nixos/${machineName}/configuration.nix {inherit config lib pkgs vars;})
    #     ];
    #   };

    mkDarwinConfig = machineName: machineConfig: let
      pkgs = nixpkgs.legacyPackages.${machineConfig.system};
      configuration = {
        lib,
        pkgs,
        config,
        ...
      }:
        import ./machines/darwin/${machineName}/configuration.nix {inherit config lib pkgs vars;};
    in
      nix-darwin.lib.darwinSystem {
        system = machineConfig.system;
        modules = [
          configuration
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${vars.user} = {
              config,
              lib,
              pkgs,
              ...
            }:
              import ./machines/darwin/${machineName}/home.nix {inherit config lib pkgs vars;};
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
          }
        ];
      };

    # nixosConfigurations = builtins.mapAttrs (name: config: mkNixOSConfig name config)
    #   (builtins.filterAttrs (name: config: config.system == "x86_64-linux") machines);

    darwinConfigurations = builtins.mapAttrs (name: config: mkDarwinConfig name config)
      (builtins.filterAttrs (name: config: builtins.hasAttr "aarch64-darwin" [config.system]) machines);
}
