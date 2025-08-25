{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
  }: let
    vars = {
      user = "k";
      computerName = "nixos";
      terminal = "alacritty";
      editor = "nvim";
    };
    configuration = {
      lib,
      pkgs,
      config,
      ...
    }:
      import ./configuration.nix {inherit config lib pkgs vars;};
  in {
    nixosConfigurations.${vars.computerName} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        configuration
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
            home-manager.users."${vars.user}" = lib.mkMerge [
              (import ../../../users/${vars.user}/default.nix {inherit config lib vars pkgs;})
              (import ./home.nix {inherit config lib vars pkgs;})
            ];
            home-manager.backupFileExtension = "backup";
          }
        )
      ];
    };
  };
}
