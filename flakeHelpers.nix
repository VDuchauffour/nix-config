{
  mkDarwin = machineHostname: nixpkgsVersion: extraHmModules: extraModules: {
    darwinConfigurations.${machineHostname} = inputs.nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        inputs.agenix.darwinModules.default
        ./machines/darwin
        ./machines/darwin/${machineHostname}
        inputs.home-manager-unstable.darwinModules.home-manager
        (nixpkgsVersion.lib.attrsets.recursiveUpdate (homeManagerCfg true extraHmModules) {
          home-manager.users.notthebee.home.homeDirectory = nixpkgsVersion.lib.mkForce "/Users/notthebee";
        })
      ];
    };
  };
  mkNixos = machineHostname: nixpkgsVersion: extraModules: {
    nixosConfigurations.${machineHostname} = nixpkgsVersion.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules =
        [
          ./homelab
          ./machines/nixos/_common
          ./machines/nixos/${machineHostname}
          ./modules/email
          ./modules/tg-notify
          ./modules/auto-aspm
          ./modules/mover
          inputs.agenix.nixosModules.default
          ./users/notthebee
          (homeManagerCfg false [])
        ]
        ++ extraModules;
    };
  };
  mkMerge = inputs.nixpkgs.lib.lists.foldl' (
    a: b: inputs.nixpkgs.lib.attrsets.recursiveUpdate a b
  ) {};
}
