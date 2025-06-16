{
  description = "Minimal NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    common = import ../common/packages;
  in {
    environment.systemPackages = with pkgs; [
      common.packages.cli
      common.packages.gui

      # system
      brightnessctl
      pavucontrol
    ];

    # homeConfigurations = {
    #   "k@nixos" = home-manager.lib.homeManagerConfiguration {
    #     pkgs = nixpkgs.legacyPackages.${system};
    #     modules = [./home.nix];
    #   };
    # };
  };
}
