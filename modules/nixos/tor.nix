{ lib, ... }: {
  services.tor = {
    enable = true;
    client.enable = true;
    settings = {
      HTTPTunnelPort = 9080;
    };
  };
  systemd.services.tor.wantedBy = lib.mkForce [ ];
}
