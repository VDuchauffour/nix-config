{inputs, ...}: let
  homeManagerCfg = metaConfig: useUserPackages: extraImports: {
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
          ./users/${metaConfig.userName}/default.nix
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
          ./machines/darwin/${machineHostname}/configuration.nix
          (nixpkgsVersion.lib.attrsets.recursiveUpdate (homeManagerCfg metaConfig true ([./machines/darwin/${machineHostname}/home.nix] ++ extraHmModules)) {
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
          ./machines/nixos/${machineHostname}/configuration.nix
          (homeManagerCfg metaConfig false ([
              ./machines/nixos/${machineHostname}/home.nix
            ]
            ++ extraHmModules))
        ]
        ++ extraModules;
    };
  };

  mkMerge = inputs.nixpkgs.lib.lists.foldl' (
    a: b: inputs.nixpkgs.lib.attrsets.recursiveUpdate a b
  ) {};
}
