{
  description = "Jamshid's daily driver";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grim-hyprland = {
      url = "github:eriedaberrie/grim-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nvf,
      grim-hyprland,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unspkgs = nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        omen = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs unspkgs;
          };
          modules = [
            ./system/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs unspkgs nvf;
              };
              home-manager.backupCommand = "${pkgs.trash-cli}/bin/trash-put";
              home-manager.users.jroid = ./users/jroid/home.nix;
            }
          ];
        };
      };
    };
}
