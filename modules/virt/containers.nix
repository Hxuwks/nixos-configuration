{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.virt.containers;
in {
  options.modules.virt.containers = {
    enable = mkEnableOption "Containerization (Docker, Podman, Containerlab)";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    virtualisation.podman.enable = true;

    environment.systemPackages = with pkgs; [
      docker-compose
      containerlab
    ];
  };
}
