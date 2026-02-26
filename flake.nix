{
  description = "My unified Nix configuration";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/VDuchauffour/nix-private.git";
      flake = false;
    };
    mac-app-util.url = "github:hraban/mac-app-util";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae.url = "github:vicinaehq/vicinae";
    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-openclaw = {
      url = "github:openclaw/nix-openclaw";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    openchamber = {
      url = "github:VDuchauffour/openchamber/feat/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {self, ...} @ inputs: let
    metaConfig = {
      userName = "k";
    };
    helpers = import ./flakeHelpers.nix {inherit inputs;};
    inherit (helpers) mkMerge mkNixos mkDarwin mkRaspberryPiNixos mkStandalone;
  in
    mkMerge [
      (mkNixos "deckard" "x86_64-linux" metaConfig inputs.nixpkgs-unstable [
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.nixos-hardware.nixosModules.common-gpu-intel
          inputs.nixos-hardware.nixosModules.common-pc-laptop
          inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
          inputs.home-manager-unstable.nixosModules.home-manager
          inputs.disko.nixosModules.disko
          ./modules/system/systemd-boot
          ./modules/system/g810-led
          ./modules/system/logid-m3s
          # ./modules/system/solaar
          ./modules/system/keyboard
          ./modules/system/laptop
          ./modules/system/nixos-desktop.nix
          inputs.solaar.nixosModules.default
        ] [
          ./modules/user/common-desktop.nix
          ./modules/user/nixos-desktop.nix
          # ./modules/user/gcloud
          ./modules/user/kubernetes-tooling
          ./modules/user/terraform
          inputs.vicinae.homeManagerModules.default
        ])
      (mkNixos "wallace" "x86_64-linux" metaConfig inputs.nixpkgs-unstable [
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.nixos-hardware.nixosModules.common-gpu-intel
          inputs.nixos-hardware.nixosModules.common-gpu-nvidia
          inputs.nixos-hardware.nixosModules.common-pc-laptop
          inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
          # inputs.nixos-hardware.nixosModules.common-gpu-nvidia
          inputs.home-manager-unstable.nixosModules.home-manager
          ./modules/system/systemd-boot
          ./modules/system/g810-led
          ./modules/system/logid-m3s
          # ./modules/system/solaar
          ./modules/system/keyboard
          ./modules/system/laptop
          ./modules/system/nixos-desktop.nix
          inputs.solaar.nixosModules.default
        ] [
          ./modules/user/common-desktop.nix
          ./modules/user/nixos-desktop.nix
          # ./modules/user/gcloud
          ./modules/user/kubernetes-tooling
          ./modules/user/terraform
          inputs.vicinae.homeManagerModules.default
        ])
      (mkDarwin "tyrell" "aarch64-darwin" metaConfig inputs.nixpkgs-unstable [
          inputs.home-manager-unstable.darwinModules.home-manager
          ./modules/system/g810-led
          ./modules/system/logid-m3s
        ] [
          ./modules/user/common-desktop.nix
        ])
      (mkNixos "joi" "x86_64-linux" metaConfig inputs.nixpkgs-unstable [
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.home-manager-unstable.nixosModules.home-manager
          ./modules/system/systemd-boot
          ./modules/system/homelab.nix
          ./modules/system/agenix
          {
            nixpkgs.overlays = [
              inputs.nix-openclaw.overlays.default
              (final: prev: {
                openchamber = inputs.openchamber.packages.${final.system}.default;
              })
            ];
          }
        ] [
          ./modules/user/kubernetes-tooling
          ./modules/user/terraform
          inputs.nix-openclaw.homeManagerModules.openclaw
          ./modules/user/openclaw
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
