{
  description = "My unified Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05?shallow=true";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable?shallow=true";
    nixpkgs-nixos.url = "github:nixos/nixpkgs/nixos-unstable?shallow=true";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master?shallow=true";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05?shallow=true";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master?shallow=true";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    agenix = {
      url = "github:ryantm/agenix?shallow=true";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/VDuchauffour/nix-private.git";
      flake = false;
    };
    mac-app-util.url = "github:hraban/mac-app-util?shallow=true";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix?shallow=true";
    elephant.url = "github:abenz1267/elephant";
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-nixos,
    home-manager,
    home-manager-unstable,
    agenix,
    secrets,
    mac-app-util,
    apple-fonts,
    elephant,
    walker,
  }: let
    metaConfig = {
      userName = "k";
    };
    helpers = import ./flakeHelpers.nix {inherit inputs;};
    inherit (helpers) mkMerge mkNixos mkDarwin;
  in
    mkMerge [
      (mkDarwin "tyrell" metaConfig inputs.nixpkgs-unstable [
          inputs.home-manager-unstable.darwinModules.home-manager
          ./modules/system/g810-led
          ./modules/system/logid-m3s
        ] [
          ./modules/user/common-desktop.nix
        ])
      (mkNixos "deckard" metaConfig inputs.nixpkgs-unstable [
          inputs.home-manager-unstable.nixosModules.home-manager
          ./modules/system/g810-led
          ./modules/system/logid-m3s
          ./modules/system/laptop
          ./modules/system/nixos-desktop.nix
        ] [
          ./modules/user/common-desktop.nix
          ./modules/user/nixos-desktop.nix
          ./modules/user/gcp
          inputs.walker.homeManagerModules.default
        ])
      (mkNixos "sebastian" metaConfig inputs.nixpkgs-unstable [
          inputs.home-manager-unstable.nixosModules.home-manager
          ./modules/system/homelab.nix
        ] [
        ])
    ];
}
