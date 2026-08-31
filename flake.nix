{
  description = "Jamshid's daily driver";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-cuda.url = "github:NixOS/nixpkgs/b4e7070cfbea488aa0d86218b4c3d604b7e71747";

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
    nbfc-linux = {
      url = "github:nbfc-linux/nbfc-linux?dir=pkgbuilds/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:denful/import-tree";
  };

  outputs =
    { self, nixpkgs-cuda, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs-cuda = import nixpkgs-cuda {
        inherit system;
        config = {
          allowUnfree = true;
          cudaSupport = true;
        };
      };
    in
    {
      nixosConfigurations = import lib/gen-hosts.nix inputs;

      packages = {
        ffmpeg-full = pkgs-cuda.ffmpeg-full.override {
          withNvcodec = true;
        };
        mpv-unwrapped = pkgs-cuda.mpv-unwrapped.override {
          ffmpeg = self.packages.ffmpeg-full;
        };
      };
    };

  nixConfig = {
    experimental-features = [ "pipe-operators" ];
  };
}
