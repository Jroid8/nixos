{
  secrets,
  lib,
  config,
  ...
}:
let
  cfg = config.custom.syncthing;
  deviceList =
    secrets.syncthing.devices
    |> lib.mapAttrsToList (dn: _: dn)
    |> lib.lists.remove cfg.currentDevice;
  devices =
    secrets.syncthing.devices
    |> lib.flip builtins.removeAttrs [ cfg.currentDevice ]
    |> builtins.mapAttrs (_: dc: dc // { compression = "always"; });
  folders = builtins.mapAttrs (
    _: fc:
    {
      versioning = {
        type = "trashcan";
        params.cleanoutDays = "7";
      };
    }
    // fc
    // {
      devices = deviceList;
    }
  ) secrets.syncthing.folders.${cfg.currentDevice};
in
{
  options = {
    custom.syncthing = {
      enable = lib.mkEnableOption "customized syncthing";
      currentDevice = lib.mkOption {
        type = lib.types.str;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      settings = {
        gui = {
          theme = "black";
        };
        options = {
          globalAnnounceEnabled = false;
        };
        inherit devices folders;
      };
    };
  };
}
