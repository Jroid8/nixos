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
      in
      lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          (inputs.import-tree ../modules/nixos)
          "${hostPath}/system/configuration.nix"
          inputs.nix-index-database.nixosModules.default
          inputs.nur.modules.nixos.default
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
              users =
                builtins.readDir hostPath
                |> lib.attrsets.filterAttrs (n: t: t == "directory" && n != "system")
                |> builtins.attrNames
                |> genAttrs (user: "${hostPath}/${user}/home.nix");
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
