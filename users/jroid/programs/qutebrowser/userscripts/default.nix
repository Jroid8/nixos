{ pkgs, config, ... }: {
  custom-pkgs.qute-bitwarden = pkgs.writers.writePython3Bin "qute-bitwarden" {
    libraries = [ pkgs.python3Packages.tldextract ];
    makeWrapperArgs = [
      "--prefix"
      "PATH"
      ":"
      "${config.custom-pkgs.rofi}/bin/rofi"
    ];
    doCheck = false;
  } ./qute-bitwarden.py;
}
