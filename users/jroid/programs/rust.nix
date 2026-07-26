{ pkgs, lib, ... }: {
  programs.cargo = {
    enable = true;
    settings = {
      build.rustc-wrapper = "${lib.getExe pkgs.sccache}";
      target.x86_64-unknown-linux-gnu = {
        linker = "clang";
        rustflags = [
          "-C"
          "link-arg=-fuse-ld=${lib.getExe pkgs.mold}"
          "-C"
          "target-cpu=native"
        ];
      };
    };
  };
}
