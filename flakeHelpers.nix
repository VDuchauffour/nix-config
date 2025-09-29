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
          ./modules/home/${metaConfig.userName}
          ./hosts/${platformName}/${machineHostname}/home.nix
        ]
        ++ extraImports;
    };
  };
in {
  mkDarwin = machineHostname: metaConfig: nixpkgsVersion: extraModules: extraHmModules: {
    darwinConfigurations.${machineHostname} = inputs.nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {
        inherit inputs;
        vars = metaConfig;
      };
      modules =
        [
          inputs.mac-app-util.darwinModules.default
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

  mkNixos = machineHostname: metaConfig: nixpkgsVersion: extraModules: extraHmModules: {
    nixosConfigurations.${machineHostname} = nixpkgsVersion.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        apple-fonts = inputs.apple-fonts;
        vars = metaConfig;
      };
      modules =
        [
          ./hosts/nixos/${machineHostname}/configuration.nix
          (homeManagerCfg "nixos" machineHostname metaConfig false extraHmModules)
          {
            networking.hostName = machineHostname;
          }
        ]
        ++ extraModules;
    };
  };

  mkMerge = inputs.nixpkgs.lib.lists.foldl' (
    a: b: inputs.nixpkgs.lib.attrsets.recursiveUpdate a b
  ) {};
}
