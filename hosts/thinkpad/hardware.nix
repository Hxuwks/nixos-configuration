{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.kernelParams = [ "amd_pstate=active" "nvme_core.default_ps_max_latency_us=0" ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50; 
  };

  
  boot.kernel.sysctl = {
    "vm.swappiness" = 180;             
    "vm.watermark_boost_factor" = 0;  
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;         
  };

  
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
      mesa
    ];
  };

   
  services.power-profiles-daemon.enable = true; 

  
  services.fstrim.enable = true;

  
  services.libinput.enable = true;
}
