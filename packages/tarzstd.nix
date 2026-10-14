{
  lib,
  writers,
  pv,
  zstd,
  gawk,
  coreutils,
  gnutar,
}:
let
  tar = lib.getExe gnutar;
  du = lib.getExe' coreutils "du";
  awk = lib.getExe gawk;
in
writers.writeFishBin "tarzstd" /* fish */ ''
  set argc (count $argv)
  if test $argc -eq 0
  	echo "Target directory not specified"
  	exit 1
  else if test $argc -ge 2
  	set destdir $argv[2]
  else
  	set destdir (pwd)
  end
  set target (string replace -r "/\$" "" $argv[1])
  ${tar} -cf - $target \
    | ${lib.getExe pv} -peb -s (${du} -sb $target | ${awk} '{print $1}') \
    | ${lib.getExe zstd} -16 --long \
    > $destdir/$target.tar.zst
''
