{
  lib,
  writers,
  coreutils,
  gnutar,
  zstd,
}:

let
  tar = lib.getExe gnutar;
  zstdBin = lib.getExe zstd;
  wc = lib.getExe' coreutils "wc";
  numfmt = lib.getExe' coreutils "numfmt";
in
writers.writeFishBin "tarzstdtest" ''
  ${tar} -cf - -- "$argv[1]" \
    | ${zstdBin} -9 --long -c \
    | ${wc} -c \
    | ${numfmt} --to=si
''
