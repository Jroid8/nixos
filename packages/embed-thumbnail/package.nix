{
  lib,
  replaceVarsWith,
  runtimeShell,
  coreutils,
  imagemagick,
  mkvtoolnix-cli,
  python314,
}:
replaceVarsWith {
  name = "embed-thumbnail";
  src = ./embed-thumbnail.sh;
  dir = "bin";
  isExecutable = true;
  replacements = {
    inherit runtimeShell;
    path = lib.makeBinPath [
      coreutils
      imagemagick
      mkvtoolnix-cli
      (python314.withPackages (ps: [ ps.mutagen ]))
    ];
  };
}
