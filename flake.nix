{
  description = "My unified Nix configuration";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master?shallow=true";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main?shallow=true";
    disko = {
      url = "github:nix-community/disko?shallow=true";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11?shallow=true";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable?shallow=true";
    nixpkgs-nixos.url = "github:nixos/nixpkgs/nixos-unstable?shallow=true";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master?shallow=true";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11?shallow=true";
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
    inherit (helpers) mkMerge mkNixos mkDarwin mkRaspberryPiNixos;
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
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          # inputs.nixos-hardware.nixosModules.common-gpu-nvidia
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
          ./modules/user/kubernetes-tooling
          ./modules/user/terraform
          inputs.vicinae.homeManagerModules.default
        ])
      (mkNixos "deckard" "x86_64-linux" metaConfig inputs.nixpkgs-unstable [
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.home-manager-unstable.nixosModules.home-manager
          inputs.disko.nixosModules.disko
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
          ./modules/user/kubernetes-tooling
          ./modules/user/terraform
          inputs.vicinae.homeManagerModules.default
        ])
      (mkNixos "joi" "x86_64-linux" metaConfig inputs.nixpkgs-unstable [
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.home-manager-unstable.nixosModules.home-manager
          ./modules/system/systemd-boot
          ./modules/system/homelab.nix
        ] [
          ./modules/user/kubernetes-tooling
        ])
      (mkRaspberryPiNixos "sebastian" metaConfig [
          # inputs.nixos-hardware.nixosModules.raspberry-pi-3
          inputs.nixos-raspberrypi.nixosModules.raspberry-pi-3.base
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
          ./modules/system/locale
        ] [
        ])
    ];
}
