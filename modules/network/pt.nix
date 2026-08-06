{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.network.pt;

  # Берем иконку напрямую из пакета Cisco Packet Tracer
  ciscoIcon = pkgs.runCommand "cisco-packet-tracer-icon" {} ''
    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp ${pkgs.cisco-packet-tracer_9}/share/icons/hicolor/48x48/apps/cisco-packet-tracer-9.png $out/share/icons/hicolor/256x256/apps/cisco-packet-tracer-9.png
  '';

  ciscoDesktop = pkgs.makeDesktopItem {
    name = "cisco-packet-tracer-9";
    desktopName = "Cisco Packet Tracer 9";
    genericName = "Network Simulation Tool";
    exec = "packettracer9 %f";
    icon = "cisco-packet-tracer-9";
    categories = ["Network" "Education" "Development"];
    mimeTypes = ["application/x-pkt" "application/x-pka" "application/x-pkz"];
    startupWMClass = "PacketTracer";
  };
in {
  options.modules.network.pt = {
    enable = mkEnableOption "Cisco packet tracer integration into Nix";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      cisco-packet-tracer_9
      ciscoIcon
      ciscoDesktop
    ];
  };
}
