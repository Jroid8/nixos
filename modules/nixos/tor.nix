{ lib, config, ... }: {
  options = {
    custom.tor = {
      enable = lib.mkEnableOption "customized tor";
    };
  };
  config = lib.mkIf config.custom.tor.enable {
    services.tor = {
      enable = true;
      client.enable = true;
      settings = {
        HTTPTunnelPort = 9080;
      };
    };
    systemd.services.tor.wantedBy = lib.mkForce [ ];
  };
}
