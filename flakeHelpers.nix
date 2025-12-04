{inputs, ...}: let
  homeManagerCfg = platformName: machineHostname: metaConfig: useUserPackages: extraImports: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = useUserPackages;
      backupFileExtension = "backup";
      extraSpecialArgs = {
        inherit inputs;
        vars = metaConfig;
      };
      users.${metaConfig.userName}.imports =
        [
          ./home/${metaConfig.userName}
          ./home/${metaConfig.userName}/${platformName}.nix
          ./modules/user
          ./modules/user/${platformName}.nix

          inputs.agenix.homeManagerModules.default
        ]
        ++ extraImports;
    };
  };

  mkNixosBase = machineHostname: machineArchitecture: metaConfig: nixpkgsVersion: extraModules: extraHmModules: {
    nixosConfigurations.${machineHostname} = nixpkgsVersion.lib.nixosSystem {
      system = "${machineArchitecture}";
      specialArgs = {
        inherit inputs;
        apple-fonts = inputs.apple-fonts;
        vars = metaConfig;
      };
      modules =
        [
          ./modules/common
          ./modules/system
          ./hosts/nixos/${machineHostname}/configuration.nix

          inputs.agenix.nixosModules.default

          (homeManagerCfg "nixos" machineHostname metaConfig false extraHmModules)
          {
            networking.hostName = machineHostname;
            environment.systemPackages = [inputs.agenix.packages.${machineArchitecture}.default];
          }
        ]
        ++ extraModules;
    };
  };
in {
  mkNixos = machineHostname: machineArchitecture: metaConfig: nixpkgsVersion: extraModules: extraHmModules:
    mkNixosBase
    machineHostname
    machineArchitecture
    metaConfig
    nixpkgsVersion
    (extraModules ++ [./modules/system/nixos.nix])
    extraHmModules;

  mkRaspberryPiNixos = machineHostname: metaConfig: extraModules: extraHmModules: let
    nixosConfig = inputs.nixos-raspberrypi.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {
        inherit inputs;
        nixos-raspberrypi = inputs.nixos-raspberrypi;
        vars = metaConfig;
      };
      modules =
        [
          "${inputs.nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
          {
            nixpkgs.config.allowUnsupportedSystem = true;
          }

          ./modules/common
          ./modules/system
          ./hosts/nixos/${machineHostname}/configuration.nix
          inputs.agenix.nixosModules.default

          (homeManagerCfg "nixos" machineHostname metaConfig false extraHmModules)
          {
            networking.hostName = machineHostname;
          }
        ]
        ++ extraModules;
    };
  in {
    nixosConfigurations.${machineHostname} = nixosConfig;
    sdImage.${machineHostname} = nixosConfig.config.system.build.sdImage;
  };

  mkDarwin = machineHostname: machineArchitecture: metaConfig: nixpkgsVersion: extraModules: extraHmModules: {
    darwinConfigurations.${machineHostname} = inputs.nix-darwin.lib.darwinSystem {
      system = "${machineArchitecture}";
      specialArgs = {
        inherit inputs;
        vars = metaConfig;
      };
      modules =
        [
          inputs.mac-app-util.darwinModules.default

          ./modules/common
          ./modules/system
          ./modules/system/darwin.nix
          ./hosts/darwin/${machineHostname}/configuration.nix

          (nixpkgsVersion.lib.attrsets.recursiveUpdate (homeManagerCfg "darwin" machineHostname metaConfig true extraHmModules) {
            home-manager.sharedModules = [
              inputs.mac-app-util.homeManagerModules.default
            ];
          })
        ]
        ++ extraModules;
    };
  };

  mkMerge = inputs.nixpkgs.lib.lists.foldl' (
    a: b: inputs.nixpkgs.lib.attrsets.recursiveUpdate a b
  ) {};
}
