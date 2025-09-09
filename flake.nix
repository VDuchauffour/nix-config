{
  description = "My unified Nix configuration for all machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nixpkgs-nixos,
    home-manager,
    mac-app-util,
    apple-fonts,
  }: let
    commonVars = {
      user = "k";
      terminal = "alacritty";
      editor = "nvim";
    };
    darwinVars =
      {
        computerName = "tyrell";
        defaultBrowser = "librewolf";
      }
      // commonVars;
    nixosVars =
      {
        computerName = "deckard";
      }
      // commonVars;

    darwinConfiguration = {
      lib,
      pkgs,
      config,
      ...
    }:
      import ./machines/darwin/tyrell/configuration.nix {
        inherit config lib pkgs;
        vars = darwinVars;
      };

    nixosConfiguration = {
      lib,
      pkgs,
      config,
      apple-fonts,
      ...
    }:
      import ./machines/nixos/deckard/configuration.nix {
        inherit config lib pkgs apple-fonts;
        vars = nixosVars;
      };
  in {
    darwinConfigurations.${darwinVars.computerName} = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        darwinConfiguration
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
            home-manager.users."${darwinVars.user}" = lib.mkMerge [
              (import ./users/${darwinVars.user}/default.nix {
                inherit config lib pkgs;
                vars = darwinVars;
              })
              (import ./machines/darwin/${darwinVars.computerName}/home.nix {
                inherit config lib pkgs;
                vars = darwinVars;
              })
            ];
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
          }
        )
      ];
    };

    nixosConfigurations.${nixosVars.computerName} = nixpkgs-nixos.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit apple-fonts;
      };
      modules = [
        nixosConfiguration
        home-manager.nixosModules.home-manager
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
            home-manager.users."${nixosVars.user}" = lib.mkMerge [
              (import ./users/${nixosVars.user}/default.nix {
                inherit config lib pkgs;
                vars = nixosVars;
              })
              (import ./machines/nixos/${nixosVars.computerName}/home.nix {
                inherit config lib pkgs;
                vars = nixosVars;
              })
            ];
            home-manager.backupFileExtension = "backup";
          }
        )
      ];
    };
  };
}
