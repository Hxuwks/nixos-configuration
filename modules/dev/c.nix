{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.dev.c;
in {
  options.modules.dev.c = {
    enable = mkEnableOption "C/C++ Development Toolchain";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gcc
      gnumake
      cmake
      gdb
      clang
    ];
  };
}
