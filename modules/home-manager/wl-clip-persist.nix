{ lib, config, ... }:
let
  cfg = config.custom.wl-clip-persist;
in
{
  options = {
    custom.wl-clip-persist.enable = lib.mkEnableOptions "customized wl-clip-persist";
  };
  config = lib.mkIf cfg.enable {
    services.wl-clip-persist = {
      enable = true;
      extraOptions = [
        "--selection-size-limit"
        "52428800"
      ];
    };
  };
}
