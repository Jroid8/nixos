pkgs:
let
  inherit (pkgs) lib;
  dirPath = builtins.toString ../packages;
  dir = builtins.readDir ../packages;
  callPackage = lib.callPackageWith (pkgs // mypkgs);
  mypkgs =
    (
      lib.attrsets.filterAttrs (_: t: t == "directory") dir
      |> builtins.attrNames
      |> lib.flip lib.genAttrs (dir: "${dir}/package.nix")
    )
    // (
      lib.attrsets.filterAttrs (_: t: t == "regular") dir
      |> builtins.attrNames
      |> lib.flip lib.genAttrs' (file: {
        name = lib.strings.removeSuffix ".nix" file;
        value = file;
      })
    )
    |> builtins.mapAttrs (_: file: callPackage "${dirPath}/${file}" { });
in
mypkgs
