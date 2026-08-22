{ inputs, pkgs, ... }:
let
  nbfc-pkg = inputs.nbfc-linux.packages.x86_64-linux.default.overrideAttrs (oldAttrs: {
    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.jq ];
    postInstall = (oldAttrs.postInstall or "") + /* sh */ ''
      echo '{"SelectedConfigId": "HP Omen 16 n0xxx GPU disabled"}' > $out/etc/nbfc/nbfc.json
      jq -cM '. + {NotebookModel: "HP Omen 16 n0xxx GPU disabled",FanConfigurations: [.FanConfigurations[] | del(.Sensors | select(. == ["@GPU"]))]}' "$out/share/nbfc/configs/HP Omen 16 n0xxx.json" > "$out/share/nbfc/configs/HP Omen 16 n0xxx GPU disabled.json"
    '';
  });
in
{
  environment.systemPackages = [ nbfc-pkg ];
  systemd.services.nbfc_service = {
    enable = true;
    description = "NoteBook FanControl service";
    serviceConfig.Type = "simple";
    path = [ pkgs.kmod ];
    script = "${nbfc-pkg}/bin/nbfc_service";
    wantedBy = [ "multi-user.target" ];
  };
}
