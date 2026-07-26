{ pkgs, ... }: {
  security.doas = {
    enable = true;
    extraRules = [
      {
        users = [ "root" ];
        noPass = true;
      }
      {
        groups = [ "wheel" ];
        persist = true;
      }
      {
        groups = [ "wheel" ];
        cmd = "${pkgs.grub2.out}/bin/grub-set-default";
        noPass = true;
      }
    ];
  };
}
