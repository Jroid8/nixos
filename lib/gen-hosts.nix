inputs:
let
  lib = inputs.nixpkgs.lib;
  genAttrs = lib.flip lib.attrsets.genAttrs;
  mkHost =
    hostName:
    (
      let
        hostPath = "../hosts/${hostName}";
        system = builtins.readFile "${hostPath}/system.txt" |> lib.strings.trim;
        users =
          builtins.readDir hostPath
          |> lib.attrsets.filterAttrs (_: t: t == "directory")
          |> builtins.attrNames
          |> genAttrs (user: "${hostPath}/${user}/home.nix")
          |> lib.attrsets.filterAttrs (_: builtins.pathExists);
        mypkgs = import ./my-packages.nix;
        specialArgs = {
          inherit inputs mypkgs;
        };
      in
      lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          (inputs.import-tree ../modules/nixos)
          "${hostPath}/system/configuration.nix"
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
            };
          }
        ];
      }
    );
in
builtins.readDir ./hosts
|> lib.attrsets.filterAttrs (_: t: t == "directory")
|> builtins.attrNames
|> genAttrs mkHost
