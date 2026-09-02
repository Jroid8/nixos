{ lib, config, ... }: 
{
  options = {
    custom.locale = {
      enable = lib.mkEnableOption "customized locale";
    };
  };
  config = lib.mkIf config.custom.locale {
    time.timeZone = "Asia/Tehran";
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocales = [ "fa_IR/UTF-8" ];
    };
  };
}
