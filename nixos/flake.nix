{
  description = "Minimal NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    ,
    } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      packages = import ../common/packages { inherit pkgs; };
    in
    {
      environment.systemPackages = packages.cli ++ packages.gui ++ [
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
