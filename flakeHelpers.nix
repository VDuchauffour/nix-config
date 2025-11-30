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
in {
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

          ./hosts/darwin/${machineHostname}/configuration.nix
          ./modules/system
          ./modules/system/darwin.nix

          (nixpkgsVersion.lib.attrsets.recursiveUpdate (homeManagerCfg "darwin" machineHostname metaConfig true extraHmModules) {
            home-manager.sharedModules = [
              inputs.mac-app-util.homeManagerModules.default
            ];
          })
        ]
        ++ extraModules;
    };
  };

  mkNixos = machineHostname: machineArchitecture: metaConfig: nixpkgsVersion: extraModules: extraHmModules: {
    nixosConfigurations.${machineHostname} = nixpkgsVersion.lib.nixosSystem {
      system = "${machineArchitecture}";
      specialArgs = {
        inherit inputs;
        apple-fonts = inputs.apple-fonts;
        vars = metaConfig;
      };
      modules =
        [
          ./hosts/nixos/${machineHostname}/configuration.nix
          ./modules/system
          ./modules/system/nixos.nix

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

  mkMerge = inputs.nixpkgs.lib.lists.foldl' (
    a: b: inputs.nixpkgs.lib.attrsets.recursiveUpdate a b
  ) {};
}
