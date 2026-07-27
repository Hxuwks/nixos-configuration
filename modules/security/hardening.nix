{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.security.hardening;
in {
  options.modules.security.hardening = {
    enable = mkEnableOption "Security Hardening and Firewall";
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
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
