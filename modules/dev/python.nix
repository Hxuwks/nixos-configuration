{ config, pkgs, lib, ... }:

with lib;
let 
  cfg = config.modules.dev.python;
  
  # Описываем набор нужных Python-пакетов
  myPythonPackages = pkgs.python3.withPackages (ps: with ps; [
    requests
    scapy
  ]);
in {
  options.modules.dev.python = {
    enable = mkEnableOption "Python 3 Environment with Core Libraries";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      myPythonPackages
    ];
  };
}
