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
    }: {
      nix.settings.experimental-features = "nix-command flakes";
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 6;
      nixpkgs.hostPlatform = ${system};
      nixpkgs.config.allowUnfree = true;

      users.users.k = {
        home = "/home/${vars.user}";
        name = "${vars.user}";
      };

      packages = import ../common/packages {inherit pkgs;};
      environment.systemPackages =
        packages.cli
        ++ packages.gui
        ++ [
          playerctl
          brightnessctl
          pavucontrol
        ];

      fonts = {
        packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
      };

      environment.variables = rec {
        EDITOR = "${vars.editor}";
        VISUAL = "${vars.editor}";
      };
    };
  in {
      homeConfigurations.${vars.computerName} = home-manager.lib.homeManagerConfiguration {
        system = ${system};
        pkgs = nixpkgs.legacyPackages.${system};
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
              home-manager.users.k = import ./home.nix {inherit config lib vars pkgs;};
              home-manager.backupFileExtension = "backup";
            }
          )
        ];
      };

      # dans user ajouté docker comme groupe
  };
}
