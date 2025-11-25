{
  description = "My unified Nix configuration";

  nixConfig = {
    extra-substituters = ["https://vicinae.cachix.org"];
    extra-trusted-public-keys = ["vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="];
  };

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
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae.url = "github:vicinaehq/vicinae";
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
    solaar,
    vicinae,
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
      (mkNixos "wallace" metaConfig inputs.nixpkgs-unstable [
          inputs.home-manager-unstable.nixosModules.home-manager
          ./modules/system/g810-led
          ./modules/system/logid-m3s
          # ./modules/system/solaar
          ./modules/system/laptop
          ./modules/system/nixos-desktop.nix
          inputs.solaar.nixosModules.default
        ] [
          ./modules/user/common-desktop.nix
          ./modules/user/nixos-desktop.nix
          ./modules/user/gcp
          inputs.vicinae.homeManagerModules.default
        ])
      (mkNixos "deckard" metaConfig inputs.nixpkgs-unstable [
          inputs.home-manager-unstable.nixosModules.home-manager
          ./modules/system/g810-led
          ./modules/system/logid-m3s
          # ./modules/system/solaar
          ./modules/system/laptop
          ./modules/system/nixos-desktop.nix
          inputs.solaar.nixosModules.default
        ] [
          ./modules/user/common-desktop.nix
          ./modules/user/nixos-desktop.nix
          ./modules/user/gcp
          inputs.vicinae.homeManagerModules.default
        ])
      (mkNixos "joi" metaConfig inputs.nixpkgs-unstable [
          inputs.home-manager-unstable.nixosModules.home-manager
          ./modules/system/homelab.nix
        ] [
        ])
    ];
}
