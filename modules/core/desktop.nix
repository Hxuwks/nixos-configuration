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
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      xkb = {
        layout = "us,ru";
        options = "grp:win_space_toggle";
      };
    };

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    services.printing.enable = false;

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-extension-manager

      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.blur-my-shell

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
