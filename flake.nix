{
  description = "My unified Nix configuration";

  nixConfig = {
    extra-trusted-substituters = [
      "https://cachix.cachix.org"
      "https://nixpkgs.cachix.org"
      "https://nix-community.cachix.org"
      "https://vicinae.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae.url = "github:vicinaehq/vicinae";
  };

  outputs = {self, ...} @ inputs: let
    metaConfig = {
      userName = "k";
    };
    helpers = import ./flakeHelpers.nix {inherit inputs;};
    inherit (helpers) mkMerge mkNixos mkDarwin;
  in
    mkMerge [
      (mkDarwin "tyrell" "aarch64-darwin" metaConfig inputs.nixpkgs-unstable [
          inputs.home-manager-unstable.darwinModules.home-manager
          ./modules/system/g810-led
          ./modules/system/logid-m3s
        ] [
          ./modules/user/common-desktop.nix
        ])
      (mkNixos "wallace" "x86_64-linux" metaConfig inputs.nixpkgs-unstable [
          inputs.home-manager-unstable.nixosModules.home-manager
          ./modules/system/systemd-boot
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
      (mkNixos "deckard" "x86_64-linux" metaConfig inputs.nixpkgs-unstable [
          # inputs.nixos-hardware.nixosModules.dell-xps-13-9310
          inputs.home-manager-unstable.nixosModules.home-manager
          ./modules/system/systemd-boot
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
      (mkNixos "joi" "x86_64-linux" metaConfig inputs.nixpkgs-unstable [
          inputs.home-manager-unstable.nixosModules.home-manager
          ./modules/system/systemd-boot
          ./modules/system/homelab.nix
        ] [
        ])
      (mkNixos "sebastian" "aarch64-linux" metaConfig inputs.nixpkgs-unstable [
          inputs.nixos-hardware.nixosModules.raspberry-pi-3
          inputs.disko.nixosModules.disko
          inputs.home-manager-unstable.nixosModules.home-manager
        ] [
        ])
    ];
}
