{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.nbfc;
  nbfc-pkg = inputs.nbfc-linux.packages.x86_64-linux.default.overrideAttrs (oldAttrs: {
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
      package = lib.mkOption {
        types = lib.types.package;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    systemd.services.nbfc_service = {
      enable = true;
      description = "NoteBook FanControl service";
      serviceConfig.Type = "simple";
      path = [ pkgs.kmod ];
      script = "${cfg.package}/bin/nbfc_service";
      wantedBy = [ "multi-user.target" ];
    };
  };
}
