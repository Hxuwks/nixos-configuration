{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.network.analysis;

  ostinatoRootScript = pkgs.writeShellScriptBin "ostinato-root-launch" ''
    ${pkgs.xhost}/bin/xhost +local:root
    pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY ${pkgs.ostinato}/bin/ostinato
  '';

  ostinatoDesktop = pkgs.makeDesktopItem {
    name = "ostinato-root";
    desktopName = "Ostinato (Root)";
    comment = "Packet Crafting Tool (Root)";
    type = "Application";
    exec = "${ostinatoRootScript}/bin/ostinato-root-launch";
    icon = "network-wired";
    startupWMClass = "ostinato";
    categories = [ "Network" "System" ];
  };

in {
  options.modules.network.analysis = {
    enable = mkEnableOption "Network Analysis & Diagnostics Toolkit";
  };

  config = mkIf cfg.enable {
    programs.wireshark.enable = true;
    security.polkit.enable = true;

    environment.systemPackages = with pkgs; [
      wireshark
      tshark
      tcpdump
      iproute2
      bind.dnsutils
      inetutils
      traceroute
      mtr
      iperf3
      nmap
      socat
      netcat-openbsd
      wireguard-tools
      bruno
      ostinato
      ostinatoRootScript
      ostinatoDesktop
    ];
  };
}
