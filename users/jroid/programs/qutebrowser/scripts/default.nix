{ pkgs, lib, ... }:
let
  qb-cleaner = pkgs.replaceVarsWith {
    name = "qb-cleaner";
    src = ./cleaner.fish;
    dir = "bin";
    isExecutable = true;
    replacements = {
      fish = lib.getExe pkgs.fish;
      path = lib.makeBinPath [
        pkgs.sqlite
        pkgs.python314Packages.plyvel
      ];
    };
  };
in
{
  home.packages = [ qb-cleaner ];
}
