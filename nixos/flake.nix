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
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    packages = import ../common/packages {inherit pkgs;};
    vars = {
      user = "k";
      computerName = "nixos";
      terminal = "alacritty";
      editor = "nvim";
    };
  in {
    nixosConfigurations.${vars.computerName} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          nix.settings.experimental-features = "nix-command flakes";
          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = "25.05";
          nixpkgs.hostPlatform = "x86_64-linux";
          nixpkgs.config.allowUnfree = true;

          users.users.k = {
            home = "/home/${vars.user}";
            name = "${vars.user}";
            isNormalUser = true;
            extraGroups = ["wheel" "docker"];
          };

          environment.systemPackages =
            packages.cli
            ++ packages.gui
            ++ [
              pkgs.playerctl
              pkgs.brightnessctl
              pkgs.pavucontrol
            ];

          fonts = {
            packages = builtins.filter nixpkgs.lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
          };

          environment.variables = rec {
            EDITOR = "${vars.editor}";
            VISUAL = "${vars.editor}";
          };
        }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.k = {config, lib, pkgs, ...}: import ./home.nix {inherit config lib pkgs vars;};
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}
