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
        packettracer8 = {
          executable = lib.getExe pkgs.ciscoPacketTracer8;

          # Will still want a .desktop entry as the package is not directly added
          desktop = "${pkgs.ciscoPacketTracers}/share/applications/cisco-pt9.desktop.desktop";

          extraArgs = [
            # This should make it run in isolated netns, preventing internet access
            "--net=none"

            # firejail is only needed for network isolation so no futher profile is needed
            "--noprofile"

            # Packet tracer doesn't play nice with dark QT themes so this
            # should unset the theme. Uncomment if you have this issue.
            # ''--env=QT_STYLE_OVERRIDE=""''
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
