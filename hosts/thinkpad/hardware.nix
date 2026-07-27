{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.kernelParams = [ "amd_pstate=active" "nvme_core.default_ps_max_latency_us=0" ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50; # Выделять до 50% ОЗУ под сжатый swap (можно изменить на 60-100% при необходимости)
  };

  # Оптимизация работы со swap в ОЗУ (активно используем zram до обращения к файлу/диску)
  boot.kernel.sysctl = {
    "vm.swappiness" = 180;             # Агрессивнее сжимаем неактивные страницы в zram
    "vm.watermark_boost_factor" = 0;   # Помогает избегать микрофризов
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;             # Считываем страницы по одной (оптимально для zram)
  };

  # Инициализация графического ядра amdgpu в раннем initrd
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Аппаратное ускорение видео (VA-API / VDPAU для AMD Radeon Graphics)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
      mesa
    ];
  };

  # Оптимизация энергосбережения и батареи 
  services.power-profiles-daemon.enable = true; 

  # Автоматический TRIM для NVMe SSD
  services.fstrim.enable = true;

  # Драйвер сенсорной панели ThinkPad
  services.libinput.enable = true;
}
