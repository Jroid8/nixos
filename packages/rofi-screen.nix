{
  kitty,
  terminalEmulator ? kitty,
  dmenu,
  dmenuCmd ? lib.getExe dmenu,
  writeShellApplication,
  findutils,
  lib,
  screen,
  rofi,
}:
writeShellApplication {
  name = "rofi-screen";

  runtimeInputs = [
    findutils
    screen
    rofi
  ];

  text = /* sh */ ''
    if sel=$(find "$HOME/.screen" -type s -printf %f\\n | ${dmenuCmd}); then
      exec ${lib.getExe terminalEmulator} screen -d -R "$sel" "$SHELL"
    fi
  '';
}
