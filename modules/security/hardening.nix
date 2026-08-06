{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.security.hardening;
in {
  options.modules.security.hardening = {
    enable = mkEnableOption "Security Hardening and Firewall";
  };

  config = mkIf cfg.enable {
    programs.firejail = {
      enable = true;
      wrappedBinaries = {
        packettracer9 = {
          # Обязательно два аргумента: пакет и имя исполняемого файла
          executable = lib.getExe' pkgs.cisco-packet-tracer_9 "packettracer9";
          extraArgs = [
            "--noprofile"
            "--net=none"
          ];
        };
      };
    };

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };

    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };
  };
}
