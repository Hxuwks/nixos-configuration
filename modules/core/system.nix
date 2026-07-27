{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.core.system;
in {
  options.modules.core.system = {
    enable = mkEnableOption "Core System Configuration";
  };

  config = mkIf cfg.enable {
   
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    
    time.timeZone = "Europe/Moscow";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };

    
    users.users.hxuwks = {
      isNormalUser = true;
      description = "hxuwks";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    
    nixpkgs.config.allowUnfree = true;

    
    environment.systemPackages = with pkgs; [
      vim
      wget
      curl
      git
      htop
      pciutils
      usbutils
    ];

    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
