{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.core.desktop;
in {
  options.modules.core.desktop = {
    enable = mkEnableOption "Desktop Environment (GNOME + Pipewire)";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      xkb = {
        layout = "us,ru";
        options = "grp:win_space_toggle";
      };
    };

    # Актуальные пути для GNOME и GDM без привязки к xserver
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    services.printing.enable = false;
    
    fonts = {
      enableDefaultPackages = true;
    
      packages = with pkgs; [
        # Устанавливаем только нужные Nerd-версии шрифтов
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        nerd-fonts.hack
        nerd-fonts.meslo-lg
      ];
    };
    
    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-extension-manager

      # Популярные расширения GNOME
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.blur-my-shell

      # Темы и иконки
      bibata-cursors
      colloid-icon-theme
    ];
  };
}
