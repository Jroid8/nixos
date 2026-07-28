{ lib, pkgs, ... }: {
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${lib.getExe pkgs.cage} -s -- ${lib.getExe pkgs.gtkgreet}";
    };
  };
}
