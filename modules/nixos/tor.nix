{
  services.tor = {
    enable = true;
    client.enable = true;
    settings = {
      HTTPTunnelPort = 9080;
    };
  };
}
