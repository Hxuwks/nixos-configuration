{ config, lib, ... }:

with lib;
let cfg = config.modules.core.flatpak;
in {
  options.modules.core.flatpak = {
    enable = mkEnableOption "Declarative Flatpak Management";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      uninstallUnmanaged = true;

      remotes = [{
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }];

      packages = [
        "io.github.focustimerhq.FocusTimer"
      ];
    };
  };
}
