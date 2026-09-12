{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.nbfc;
  nbfc-pkg = inputs.nbfc-linux.pkackages.x86_64-linux.default;
  omen-pkg = nbfc-pkg.overrideAttrs (oldAttrs: {
    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.jq ];
    postInstall = (oldAttrs.postInstall or "") + /* sh */ ''
      echo '{"SelectedConfigId": "HP Omen 16 n0xxx GPU disabled"}' > $out/etc/nbfc/nbfc.json
      jq -cM '. + {NotebookModel: "HP Omen 16 n0xxx GPU disabled",FanConfigurations: [.FanConfigurations[] | del(.Sensors | select(. == ["@GPU"]))]}' "$out/share/nbfc/configs/HP Omen 16 n0xxx.json" > "$out/share/nbfc/configs/HP Omen 16 n0xxx GPU disabled.json"
    '';
  });
in
{
  options = {
    custom.nbfc = {
      enable = lib.mkEnableOption "customized nbfc";
      omen16-b0xxx-patch = lib.mkEnableOption "patch for HP Omen 16-b0xxx";
    };
  };
  config = lib.mkIf cfg.enable {
    systemd.services.nbfc_service = {
      enable = true;
      description = "NoteBook FanControl service";
      serviceConfig.Type = "simple";
      path = [ pkgs.kmod ];
      script = lib.mkMerge [
        (lib.mkIf cfg.omen16-b0xxx-patch (lib.getExe' omen-pkg "nbfc_service"))
        (lib.mkIf (!cfg.omen16-b0xxx-patch) (lib.getExe' nbfc-pkg "nbfc_service"))
      ];
      wantedBy = [ "multi-user.target" ];
    };
  };
}
