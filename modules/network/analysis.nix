{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.network.analysis;
in {
  options.modules.network.analysis = {
    enable = mkEnableOption "Network Analysis & Diagnostics Toolkit";
  };

  config = mkIf cfg.enable {
    programs.wireshark.enable = true;

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
    ];
  };
}
