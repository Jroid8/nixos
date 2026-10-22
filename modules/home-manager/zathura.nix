{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.zathura;
in
{
  options = {
    custom.zathura.enable = lib.mkEnableOption "customized zathura";
  };
  config = lib.mkIf cfg.enable {
    programs.zathura.enable = true;
    xdg.mimeApps = {
      defaultApplicationPackages = with pkgs.zathuraPkgs; [
        zathura_ps
        zathura_djvu
        zathura_pdf_mupdf
      ];
      defaultApplications =
        [
          "application/vnd.comicbook+zip"
          "application/vnd.comicbook-rar"
          "application/x-cbr"
          "application/x-cbz"
          "application/x-cb7"
          "application/x-cbt"
        ]
        |> lib.flip lib.genAttrs (_: ["org.pwmt.zathura.desktop"]);
    };
  };
}
