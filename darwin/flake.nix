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
    }:
      import ./configuration.nix {inherit config lib pkgs vars;};
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
  };
}
