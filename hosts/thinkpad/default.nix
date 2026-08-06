{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ../../modules/core
    ../../modules/dev
    ../../modules/security
    ../../modules/virt
    ../../modules/network
  ];
  networking.hostName = "thinkpad";
  environment.etc."hosts".mode = "0644";

  
  modules = {
    core = {
      system.enable = true;
      desktop.enable = true;
      flatpak.enable = true;
    };

    dev = {
      c.enable = true;
      python.enable = true;
    };

    security = {
      hardening.enable = true;
      pentest.enable = true;
    };

    virt = {
      containers.enable = true;
      virtualization.enable = true;
    };

    network = {
      analysis.enable = true;
      pt.enable = true;
      services = {
        vpn.enable = true;
      };
    };
  };

  users.groups.clab_admins = {};

  
  users.users.hxuwks.extraGroups = [
    "wheel"
    "networkmanager"
    "wireshark"
    "docker"
    "libvirtd"
    "clab_admins"
  ];

  system.stateVersion = "26.05";
}
