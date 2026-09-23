{ pkgs, config, lib, ... }:
let
  rofi = config.custom.rofi.finalPackage;
  kitty = lib.getExe pkgs.kitty;
in
{
  custom = {
    librewolf.enable = true;
    noctalia.enable = true;
    nvf.enable = true;
    rofi.enable = true;
    direnv.enable = true;
    eza.enable = true;
    equibop.enable = true;
    feh.enable = true;
    fish.enable = true;
    fzf.enable = true;
    git.enable = true;
    kitty.enable = true;
    starship.enable = true;
    v2rayn.enable = true;
    yt-dlp.enable = true;
    zathura.enable = true;

    hyprland = {
      enable = true;
      aquamarine-drm-devices = "/dev/dri/intel-igpu";
      rofi = lib.getExe rofi;
      gamelauncher.command = "${config.programs.game-launching-tools.gametimePackage}/bin/gametime";
      mps = lib.getExe config.programs.mps.finalPackage;
      terminalEmulator = kitty;
      wallpaperSwitch.command = "${lib.getExe config.programs.noctalia.package} wallpaper-random";
      textEditor.command = "${kitty} ${lib.getExe config.programs.nvf.finalPackage}";
      openNotes.command = "${kitty} -d Notes ${lib.getExe config.programs.nvf.finalPackage} index.norg";
    };
    mpv = {
      enable = true;
      cuda = true;
    };
    rbw = {
      pinentry = pkgs.pinentry-rofi.override (_: {
        inherit rofi;
      });
    };
    yazi = {
      enable = true;
      rofi = lib.getExe rofi;
    };
  };
  programs = {
    bash.enable = true;
    embed-thumbnail.enable = true;
    game-launching-tools.enable = true;
    home-manager.enable = true;
    tarzstd.enable = true;

    mps = {
      enable = true;
      dmenu = rofi;
    };
  };
}
