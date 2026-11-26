{
  config,
  lib,
  pkgs,
  ...
}:
let cfg = config.custom.bqf; in
{
  options = {
    custom.bqf = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.opt = [pkgs.vimPlugins.nvim-bqf];
    lz-n = [{
      name = "nvim-bqf";
      ft = "qf";
      after = lib.mkLuaInline /* lua */ ''
        function()
          require("bqf").setup()
        end
      '';
    }];
  };
}
