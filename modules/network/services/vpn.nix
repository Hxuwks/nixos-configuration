{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.modules.network.services.vpn;

  vpnConfig = builtins.toJSON [
    {
      title = "";
      icon = "/home/hxuwks/Pictures/icons/amnezia-light.svg";
      position = "right";
      index = "auto";
      menu = [
        {
          title = "AmneziaWG On";
          icon = "network-vpn-symbolic";
          command = "sudo /run/current-system/sw/bin/awg-quick up wg0";
        }
        {
          title = "AmneziaWG Off";
          icon = "network-vpn-disabled-symbolic";
          command = "sudo /run/current-system/sw/bin/awg-quick down wg0";
        }
      ];
    }
  ];
in
{
  options.modules.network.services.vpn = {
    enable = mkEnableOption "AmneziaWG VPN Service";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      amneziawg-tools
      amneziawg-go
      gnomeExtensions.command-menu-2
    ];

    system.activationScripts.commandMenuConfig = ''
      USER_HOME="/home/hxuwks"
      if [ -d "$USER_HOME" ]; then
        echo '${vpnConfig}' > "$USER_HOME/.commands.json"
        chown hxuwks:users "$USER_HOME/.commands.json"
      fi
    '';

    security.sudo.extraRules = [
      {
        users = [ "hxuwks" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/awg-quick";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/systemctl start awg-quick@wg0";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/systemctl stop awg-quick@wg0";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
