{ inputs, pkgs, ... }:
let
  nbfc-pkg = inputs.nbfc-linux.packages.x86_64-linux.default;
  cfgjson = pkgs.writeText "nbfc.json" /* json */ ''
    {"SelectedConfigId": "HP Omen 16 n0xxx"}
  '';
in
{
  environment.systemPackages = [ nbfc-pkg ];
  systemd.services.nbfc_service = {
    enable = true;
    description = "NoteBook FanControl service";
    serviceConfig.Type = "simple";
    path = [ pkgs.kmod ];
    script = "${nbfc-pkg}/bin/nbfc_service -c ${cfgjson}";
    wantedBy = [ "multi-user.target" ];
  };
}
