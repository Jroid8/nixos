{
  config,
  pkgs,
  lib,
  ...
}:
let
  yazi-select = pkgs.writeShellApplication {
    name = "yazi-select";
    runtimeInputs = [
      pkgs.yazi
      config.terminal-emulator
    ];
    text = /* bash */ ''
      YAZI_ID="$(date +%s)$RANDOM"
      ${lib.getExe config.terminal-emulator} yazi --client-id "$YAZI_ID"
      pid=$!
      while ! ya emit reveal "$1" 2>/dev/null; do
      	sleep 0.05
      done
      for a in "$@"; do
      	ya emit toggle --state=on "$a"
      done
      wait $pid
    '';
  };
  mps = (
    pkgs.replaceVarsWith {
      name = "mps";
      src = ./mps.sh;
      dir = "bin";
      isExecutable = true;
      replacements = {
        runtimeShell = pkgs.runtimeShell;
        path = lib.makeBinPath [
          config.custom-pkgs.rofi
          pkgs.mpc
          pkgs.coreutils
          pkgs.findutils
        ];
      };
    }
  );
  gametime = pkgs.replaceVarsWith {
    name = "gametime";
    src = ./gametime.fish;
    dir = "bin";
    isExecutable = true;
    replacements = {
      fish = lib.getExe pkgs.fish;
      path = lib.makeBinPath [
        pkgs.coreutils
        pkgs.systemd
        pkgs.gamemode
      ];
    };
  };
  boot-to-windows = pkgs.writeShellApplication {
    name = "boot-to-windows";
    runtimeInputs = [
      pkgs.grub2
      pkgs.gnugrep
      pkgs.coreutils
    ];
    text = /* bash */ ''
      grub-set-default "$(grep -i "^menuentry 'Windows" /boot/grub/grub.cfg | head -n 1 | cut -d\' -f2)" && reboot
    '';
  };
in
{
  home.packages = [
    (pkgs.writers.writeFishBin "tarzstd"
      {
        makeWrapperArgs = [
          "--prefix"
          "PATH"
          ":"
          "${pkgs.lib.makeBinPath [
            pkgs.gnugrep
            pkgs.pv
            pkgs.zstd
            pkgs.coreutils
          ]}"
        ];
      }
      /* fish */ ''
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
        tar -cf - $target | pv -peb -s (du -sb $target | awk '{print $1}') | zstd -16 --long > $destdir/$target.tar.zst
      ''
    )
    (pkgs.writers.writeFishBin "tarzstdtest" "tar -cf - $argv[1] | zstd -9 --long -c | wc -c | numfmt --to=si")
    (pkgs.replaceVarsWith {
      name = "embed-thumbnail";
      src = ./embed-thumbnail.sh;
      dir = "bin";
      isExecutable = true;
      replacements = {
        runtimeShell = pkgs.runtimeShell;
        path = lib.makeBinPath [
          pkgs.coreutils
          pkgs.imagemagick
          pkgs.mkvtoolnix-cli
          (pkgs.python314.withPackages (ps: [ ps.mutagen ]))
        ];
      };
    })
    (pkgs.replaceVarsWith {
      name = "game-selector";
      src = ./game-selector.fish;
      dir = "bin";
      isExecutable = true;
      replacements = {
        fish = lib.getExe pkgs.fish;
        rofi = "${config.custom-pkgs.rofi}/bin/rofi -config ${./game-selector-rofi.rasi}";
      };
    })
    boot-to-windows
    gametime
    mps
    yazi-select
  ];
  custom-pkgs = {
    inherit
      mps
      gametime
      boot-to-windows
      yazi-select
      ;
  };
}
