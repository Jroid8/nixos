{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.custom.v2rayn;
in
{
  options = {
    custom.v2rayn.enable = lib.mkEnableOptions "customized v2rayn";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ v2rayn ];
    xdg.dataFile = {
      "v2rayN/bin/sing_box/sing-box".source = "${pkgs.sing-box}/bin/sing-box";
      "v2rayN/bin/xray/xray".source = "${pkgs.xray}/bin/xray";
    };
  };
}
