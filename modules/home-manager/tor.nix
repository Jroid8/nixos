{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.tor;
  torrc = pkgs.writeText "torrc" ''
    %include ${config.age.secrets.tor.path}
    HTTPTunnelPort 9080
    ClientTransportPlugin obfs4 exec ${lib.getExe pkgs.obfs4}
  '';
in
{
  options = {
    custom.tor = {
      enable = lib.mkEnableOption "customized TOR daemon";
    };
  };
  config = lib.mkIf cfg.enable {
    age.secrets.tor.file = ../../secrets/tor.age;
    systemd.user.services.tor = {
      Unit = {
        Description = "TOR client daemon";
        After = "network.target";
        Documentation = "man:tor(8)";
      };
      Service = {
        ExecStart = "${lib.getExe pkgs.tor} -f ${torrc}";
        ExecReload = "${lib.getExe' pkgs.coreutils "kill"} -HUP $MAINPID";
        KillSignal = "SIGINT";
      };
    };
  };
}
