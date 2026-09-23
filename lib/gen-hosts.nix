inputs:
let
  lib = inputs.nixpkgs.lib;
  genAttrs = lib.flip lib.attrsets.genAttrs;
  mkHost =
    hostName:
    (
      let
        hostPath = ./.. + "/hosts/${hostName}";
        system = builtins.readFile (hostPath + "/system.txt") |> lib.strings.trim;
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        users =
          builtins.readDir hostPath
          |> lib.attrsets.filterAttrs (_: t: t == "directory")
          |> builtins.attrNames
          |> genAttrs (user: hostPath + "/${user}/home.nix")
          |> lib.attrsets.filterAttrs (_: builtins.pathExists)
          |> builtins.mapAttrs (_: p: /. + p);
        mypkgs = import ./my-packages.nix pkgs;
        pkgs-cuda = import inputs.nixpkgs-cuda {
          inherit system;
          config = {
            allowUnfree = true;
            cudaSupport = true;
          };
        };
        specialArgs = {
          inherit inputs mypkgs pkgs-cuda;
        };
      in
      lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          (inputs.import-tree ../modules/nixos)
          (hostPath + "/system/configuration.nix")
          inputs.nix-index-database.nixosModules.default
          inputs.nur.modules.nixos.default
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              inherit users;
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                (inputs.import-tree ../modules/home-manager)
              ];
              extraSpecialArgs = specialArgs;
              backupCommand = lib.getExe' pkgs.trash-cli "trash-put";
            };
          }
        ];
      }
    );
in
builtins.readDir ../hosts
|> lib.attrsets.filterAttrs (_: t: t == "directory")
|> builtins.attrNames
|> genAttrs mkHost
